Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Incident" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Incident'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Incident -Number '1' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Pipeline input" {
            $script:TDConnected = $true

            Context "Incident by Number" {
                $pobj1 = [PSCustomObject]@{
                    Number = '1'
                }
                $param1 = $pobj1.Number
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyNumber' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents/number/' + $param1.Trim() } -Verifiable
                $Incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped an Incident Number" {
                    $Incident | Should -Not -BeNullOrEmpty
                    $Incident | Should -Be 'IncidentbyNumber'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Asset" {
                $pobj1 = [PSCustomObject]@{
                    AssetName = '1234567'
                }
                $param1 = $pobj1.AssetName
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyAssetName' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?object_name=' + $param1.Trim() } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped an Asset Name" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyAssetName'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }
        }

        Context "Calling with parameters" {
            
            $script:TDConnected = $true

            Context "Incident by Number" {
                $param1 = '1'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyNumber' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents/number/' + $param1.Trim() } -Verifiable
                $Incident = (Get-Incident -Number $param1)

                It "Should return a value" {
                    $Incident | Should -Not -BeNullOrEmpty
                    $Incident | Should -Be 'IncidentbyNumber'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Incident by Asset" {
                $param1 = '1234567'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyAssetName' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?object_name=' + $param1.Trim() } -Verifiable
                $incident = (Get-Incident -AssetName $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyAssetName'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }
        }

        Context "Parameters" {

            Context "ParameterSets" {

                Context "Default" {
                    
                    It "Should have a parameterset named Number" {
                        (Get-Command $FunctionName).ParameterSets.Name | Should -Contain 'Number'
                    }

                    It "Should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'Number' }).isDefault | Should -Be $true
                    }

                    It "Should have 1 parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'Number' }).parameters.Name | Should -Contain 'Number'
                    }

                }

                Context "byName" {

                    It "Should have a parameterset name byAssetName" {
                        (Get-Command $FunctionName).ParameterSets.Name | Should -Contain 'byAssetName'
                    }

                    It "Should have 1 parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'byAssetName' }).parameters.Name | Should -Contain  'AssetName'
                    }
                }
            }

            Context "Mandatory parameters" {

                It "Number should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'Number' -Mandatory
                }

                It "AssetName should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'AssetName' -Mandatory
                }

            }

            Context "Parameter Validation" {

                It "Number should have 2 alias" {
                    (Get-Command $FunctionName).Parameters['Number'].Aliases | Should -Contain 'id'
                    (Get-Command $FunctionName).Parameters['Number'].Aliases | Should -Contain 'IncidentNumber'
                }

                It "AssetName should have 2 alias" {
                    (Get-Command $FunctionName).Parameters['AssetName'].Aliases | Should -Contain 'AssetID'
                    (Get-Command $FunctionName).Parameters['AssetName'].Aliases | Should -Contain 'name'
                }

            }
        }
    }
}