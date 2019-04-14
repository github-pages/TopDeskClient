Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-LinkedAsset" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-LinkedAsset'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-LinkedAsset -Type 'incident' -ID '1' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {
            
            $script:TDConnected = $true

            Context "Type and ID" {
                
                $pobj1 = [PSCustomObject]@{
                    Type = 'incident'
                    ID = '1234567'
                }
                $param1 = $pobj1.Type
                $param2 = $pobj1.ID
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=linkedTo eq ' + "$param1/$param2" + '&fields=name&showAssignments=$true' } -Verifiable
                $pobj1 | Get-LinkedAsset

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Type and id with Asset Fields" {

                $pobj1 = [PSCustomObject]@{
                    Type = 'person'
                    ID = '1234567'
                    AssetFields = @('name','status')
                }
                $param1 = $pobj1.Type
                $param2 = $pobj1.ID
                $param3 = [string]::Join(",",$pobj1.AssetFields)
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=linkedTo eq ' + "$param1/$param2" + '&fields=' + $param3 + '&showAssignments=$true' } -Verifiable
                $pobj1 | Get-LinkedAsset

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }
        }

        Context "Calling with parameters" {
            
            $script:TDConnected = $true
            $param1 = 'incident'
            $param2 = '1'
            $param3 = 'name,status'

            Context "Type and id" {
                
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=linkedTo eq ' + "$param1/$param2" + '&fields=name&showAssignments=$true' } -Verifiable
                Get-LinkedAsset -Type $param1 -ID $param2

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Type and id with Fields" {

                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=linkedTo eq ' + "$param1/$param2" + '&fields=' + $param3 + '&showAssignments=$true' } -Verifiable
                Get-LinkedAsset -Type $param1 -ID $param2 -AssetFields $param3

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

        }

        Context "Parameters" {

            Context "Type" {
                
                $param = (Get-Command $FunctionName).Parameters['Type']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'Type'
                    $param.ParameterSets.Type.IsMandatory | Should -Be $true
                    $param.ParameterSets.Type.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                }

            }

            Context "ID" {
                
                $param = (Get-Command $FunctionName).Parameters['ID']
                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'Type'
                    $param.ParameterSets.Type.IsMandatory | Should -Be $true
                    $param.ParameterSets.Type.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                }    
            }

            Context "AssetFields" {

                $param = (Get-Command $FunctionName).Parameters['AssetFields']
                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParameterSets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.Aliases | Should -Contain 'fields'
                    $param.ParameterType.Name | Should -Be 'string[]'
                }    
            }

            Context "NoAssignments" {

                $param = (Get-Command $FunctionName).Parameters['NoAssignments']
                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParameterSets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.SwitchParameter | Should -Be $true
                }
            }
        }
    }
}
