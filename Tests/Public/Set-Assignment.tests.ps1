Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Set-Assignment" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Set-Assignment'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Set-Assignment -AssetID 'A1' -TemplateID 'B1' -TargetID 'C1' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {
            $script:TDConnected = $true
            $param1 = 'A1234567-4444-4444-4444-121212121212'
            $param2 = 'A2345678-4444-4444-4444-121212121212'
            $param3 = 'A3456789-4444-4444-4444-121212121212'
            $pobj1 = [PSCustomObject]@{
                AssetID = $param1
                TemplateID = $param2
                TargetID = $param3
            }
            $body = @{
                'ids' = @(
                    $param3
                )
            }
            $baseURI = '/tas/api/assetmgmt/assets/templateId/' + $param2 + '/' + $param1 + '/assignment/'

            Context "Person" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'persons'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                $pobj1 | Set-Assignment -Confirm:$false

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Branch" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'branches'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                $pobj1 | Set-Assignment -Confirm:$false

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Location" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'locations'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                $pobj1 | Set-Assignment -Confirm:$false

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "PersonGroups" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'personGroups'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                $pobj1 | Set-Assignment -Confirm:$false

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            $param1 = 'A1234567-4444-4444-4444-121212121212'
            $param2 = 'A2345678-4444-4444-4444-121212121212'
            $param3 = 'A3456789-4444-4444-4444-121212121212'
            $baseURI = '/tas/api/assetmgmt/assets/templateId/' + $param2 + '/' + $param1 + '/assignment/'
            
            Context "Person" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'persons'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                Set-Assignment -AssetID $param1 -TemplateID $param2 -TargetID $param3 -Confirm:$false

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Branch" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'branches'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                Set-Assignment -AssetID $param1 -TemplateID $param2 -TargetID $param3 -Branch -Confirm:$false

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Location" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'locations'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                Set-Assignment -AssetID $param1 -TemplateID $param2 -TargetID $param3 -Location -Confirm:$false

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "personGroups" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI + 'personGroups'; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                Set-Assignment -AssetID $param1 -TemplateID $param2 -TargetID $param3 -PersonGroup -Confirm:$false

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

        }

        Context "Parameters" {

            Context "AssetID" {

                $param = (Get-Command $FunctionName).Parameters['AssetID']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'unid'
                }
            }

            Context "TemplateID" {
                $param = (Get-Command $FunctionName).Parameters['TemplateID']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'type_id'
                }
            }

            Context "TargetID" {
                $param = (Get-Command $FunctionName).Parameters['TargetID']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                    $param.Aliases | Should -Contain 'id'
                }
            }

            Context "Branch" {
                $param = (Get-Command $FunctionName).Parameters['Branch']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'branches'
                    $param.ParameterSets.branches.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }

            Context "Location" {
                $param = (Get-Command $FunctionName).Parameters['Location']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'locations'
                    $param.ParameterSets.locations.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }

            Context "PersonGroup" {
                $param = (Get-Command $FunctionName).Parameters['PersonGroup']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'persongroups'
                    $param.ParameterSets.persongroups.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }

            Context "Person" {
                $param = (Get-Command $FunctionName).Parameters['Person']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'persons'
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.persons.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }
        }

    }
}