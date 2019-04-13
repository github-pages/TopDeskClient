Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-BlankAsset" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-BlankAsset'
        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-BlankAsset -TemplateName 'Test' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Pipeline input" {

            $script:TDConnected = $true

            Context "By Name" {

                $pobj1 = [PSCustomObject]@{
                    TemplateName = 'Computer'
                }
                $param1 = $pobj1.TemplateName
                Mock -CommandName Get-APIResponse -MockWith { return 'BlankAssetbyName' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/blank?templateName=$(' + $param1 + ')' } -Verifiable
                $BlankAsset = ($pobj1 | Get-BlankAsset)

                It "Should retrieve a blank asset by name" {
                    $BlankAsset | Should -Not -BeNullOrEmpty
                    $BlankAsset | Should -Be 'BlankAssetbyName'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "By ID" {
                $pobj1 = [PSCustomObject]@{
                    TemplateID = '12341234-1234-1234-1234-1234567890AB'
                }
                $param1 = $pobj1.TemplateID
                Mock -CommandName Get-APIResponse -MockWith { return 'BlankAssetbyID' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/blank?templateId=$(' + $param1 + ')' } -Verifiable
                $BlankAsset = ($pobj1 | Get-BlankAsset)

                It "Retrieves a blank asset by ID" {
                    $BlankAsset | Should -Not -BeNullOrEmpty
                    $BlankAsset | Should -Be 'BlankAssetbyID'
                }

                It "Performs an API call" {
                    Assert-VerifiableMock
                }

            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            
            Context "By Name" {
                $param1 = 'Computer'
                Mock -CommandName Get-APIResponse -MockWith { return 'BlankAssetbyName' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/blank?templateName=$(' + $param1 + ')'}
                $BlankAsset = (Get-BlankAsset -TemplateName $param1)

                It "Should retrieve a blank asset by name" {
                    $BlankAsset | Should -Not -BeNullOrEmpty
                    $BlankAsset | Should -Be 'BlankAssetbyName'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "By ID" {
                $param1 = '12341234-1234-1234-1234-1234567890AB'
                Mock -CommandName Get-APIResponse -MockWith { return 'BlankAssetbyID' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/blank?templateId=$(' + $param1 + ')' }
                $BlankAsset = (Get-BlankAsset -TemplateID $param1)

                It "Should retrieve a blank asset by id" {
                    $BlankAsset | Should -Not -BeNullOrEmpty
                    $BlankAsset | Should -Be 'BlankAssetbyID'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

        }

        Context "Parameters" {

            Context "ParameterSets" {

                Context "Default" {

                    It "Should have a parameterset named Default" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Default' | Should -Be $true
                    }

                    It "Should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'Default'}).IsDefault | Should -Be $true
                    }

                    It "Should have one parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'TemplateName'
                    }

                }

                Context "byID" {

                    It "Should have a parameterset name byID" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'byID' | Should -Be $true
                    }

                    it "Should have one parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'byID'}).Parameters.Name | Should -Contain 'TemplateID'
                    }

                }
            }

            Context "Mandatory parameters" {

                It "TemplateName should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'TemplateName' -Mandatory
                }

                It "TemplateID should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'TemplateID' -Mandatory
                }

            }

            Context "Parameter validation" {

                Context "TemplateName" {
                    
                    It "Should have an alias Name" {
                        (Get-Command $FunctionName).Parameters['TemplateName'].Aliases.Contains('Name') | Should -Be $true
                    }
                    
                }

                Context "TemplateID" {

                    It "Should have an alias ID" {
                        (Get-Command $FunctionName).Parameters['TemplateID'].Aliases.Contains('ID') | Should -Be $true
                    }

                }
            }
        }
    }
}