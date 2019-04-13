Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Assingment" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Assignment'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }
        $objid = [PSCustomObject]@{
            AssetID = '12341234-1234-1234-1234-1234567890AB'
        }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB'} | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline Input" {
            $script:TDConnected = $true

            $param1 = '12341234-1234-1234-1234-1234567890AB'
            Mock -CommandName Get-APIResponse -MockWith { return 'pipedAsset' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/' + $param1 + '/assignments' } -Verifiable
            $Assignment = ($objid | Get-Assignment)

            It "Returns a value when piped an id" {
                $Assignment | Should -Not -BeNullOrEmpty
            }

            It "Performs 1 API call" {
                Assert-VerifiableMock
            }
        }

        Context "With parameters" {
            $param1 = '12341234-1234-1234-1234-1234567890AB'
            $script:TDConnected = $true
            Mock -CommandName Get-APIResponse -MockWith { return 'Assignment' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/' + $param1 + '/assignments' } -Verifiable
            $Assignment = Get-Assignment -AssetID $param1

            It "Should make an API call to get an Asset Assignment" {
                $Assignment | Should -Not -BeNullOrEmpty
                $Assignment | Should -Be 'Assignment'
            }

            It "Performs an API call" {
                Assert-VerifiableMock
            }

        }

        Context "Parameters" {

            Context "ParameterSets" {

                Context "Default" {

                    It "Should have a parameterset named Default" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Default' | Should -Be $true
                    }

                    It "Default should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).isDefault | Should -Be $true
                    }

                    It "Should have AssetID parameter in Default" {
                        (Get-Command $FunctionName).ParameterSets.Where({ $_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'AssetID'
                    }

                }
            }

            Context "Mandatory parameters" {

                It "AssetID should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'AssetID' -Mandatory
                }
            }

            Context "Parameter Validation" {

                Context "AsssetID" {

                    It "Should have an alias ID" {
                        (Get-Command $FunctionName).Parameters['AssetID'].Aliases.Contains('ID') | Should -Be $true
                    }
                }
            }
        }
    }
}