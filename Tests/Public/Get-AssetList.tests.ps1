Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-AssetList" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-AssetList'

        Mock -CommandName Get-APIResponse -MockWith { return 'catch-all'}

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-AssetList -TemplateID 'D7DD7924-D6C7-465E-A811-06D51C5595C2' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {

            $script:TDConnected = $true

            Context "AssetList by TemplateID" {
                $Template = [PSCustomObject]@{
                    TemplateID = [string]'D7DD7924-D6C7-465E-A811-06D51C5595C2'
                }
                $param1 = $Template.TemplateID
                Mock -CommandName Get-APIResponse -MockWith { return 'SampleList' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/templateId/' + $param1 } -Verifiable
                $AssetList = ($Template | Get-AssetList)

                It "Returns a value when piped a TemplateID" {
                    $AssetList | Should -Not -BeNullOrEmpty
                }

                It "Performs 1 API call" {
                    $AssetList | Should -Be 'SampleList'
                    Assert-VerifiableMock
                }

                Context "with fields" {

                    $Template = [PSCustomObject]@{
                        TemplateID = [string]'D7DD7924-D6C7-465E-A811-06D51C5595C2'
                        Fields = @('name','unid')
                    }

                    $param1 = $Template.TemplateID
                    $param2 = $Template.Fields
                    Mock -CommandName Get-APIResponse -MockWith {return 'SampleList_fields'} -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/templateId/' + $param1 + '?field=' + $param2[0] + '&field=' + $param2[1] } -Verifiable
                    $AssetList = ($Template | Get-AssetList)

                    It "Returns a value when piped a TemplateID and Fields" {
                        $AssetList | Should -Not -BeNullOrEmpty
                    }

                    It "Performs 1 API call" {
                        $AssetList | Should -Be 'SampleList_fields'
                        Assert-VerifiableMock
                    }
                }
            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            Mock -CommandName Get-APIResponse -MockWith { return 'catch-all' }

            Context "Get AssetList by TemplateID" {
                [string]$param1 = 'D7DD7924-D6C7-465E-A811-06D51C5595C2'
                Mock -CommandName Get-APIResponse -MockWith { return 'SampleList' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/templateId/' + $param1 } -Verifiable

                $AssetList = (Get-AssetList -TemplateID $param1)

                It "Returns a value" {
                    $AssetList | Should -Not -BeNullOrEmpty
                    $AssetList | Should -Be 'SampleList'
                }

                It "Performs 1 API call" {
                    $AssetList | Should -Be 'SampleList'
                    Assert-VerifiableMock
                }
            }

            Context "Get AssetList with fields" {
                $param1 = 'D7DD7924-D6C7-465E-A811-06D51C5595C2'
                $param2 = @('name','unid')

                Mock -CommandName Get-APIResponse -MockWith {return 'SampleList_fields'} -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/templateId/' + $param1 + '?field=' + $param2[0] + '&field=' + $param2[1] } -Verifiable
                $AssetList = Get-AssetList -TemplateID $param1 -Fields $param2

                It "Returns a value with fields" {
                    $AssetList | Should -Not -BeNullOrEmpty
                    $AssetList | Should -Be 'SampleList_fields'
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }

            }

        }

        Context "Parameters" {

            Context "ParameterSets" {

                Context "Default" {

                    It "Should have a default parameterset named Deafault" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Default' | Should -Be $true
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).IsDefault | Should -Be $true
                    }

                    It "Should have 3 parameters in AllAssets" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).Parameters.Name | Should -Contain 'TemplateID'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).Parameters.Name | Should -Contain 'Fields'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).Parameters.Name | Should -Contain 'Archive'
                    }

                }
            }

            Context "Mandatory parameters" {

                It "TemplateID should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'TemplateID' -Type [string] -Mandatory
                }

                It "Fields should NOT be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'Fields'  -Type [string[]]
                }

                It "Archive should NOT be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'Archive'  -Type [switch]
                }
                    
            }

        }

    }
}