Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Remove-Assignment" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Remove-Assignment'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Remove-Assignment -AssetID '1' -LinkID '1' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {
            $script:TDConnected = $true

            $pobj1 = [PSCustomObject]@{
                AssetID = 'A1'
                LinkID = 'A1'
            }
            $param1 = $pobj1.AssetID
            $param2 = $pobj1.LinkID
            Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/' + $param1 + '/assignments/' + $param2 } -Verifiable
            $pobj1  | Remove-Assignment -Force

            it "Should perform an API call" {
                Assert-VerifiableMock
            }

        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            $param1 = 'A1'
            $param2 = 'A2'
            Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets/' + $param1 + '/assignments/' + $param2 } -Verifiable
            Remove-Assignment -AssetID $param1 -LinkID $param2 -Force

            It "Should perform an API call" {
                Assert-VerifiableMock
            }

        }

        Context "Parameters" {

            Context "AssetID" {
                $param = (Get-Command $FunctionName).Parameters['AssetID']

                it "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Confirm'
                    $param.ParameterSets.Keys | Should -Contain 'Force'
                    $param.ParameterSets.Confirm.IsMandatory | Should -Be $true
                    $param.ParameterSets.Force.IsMandatory | Should -Be $true
                    $param.ParameterSets.Confirm.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterSets.Force.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'unid'
                }
            }

            Context "LinkID" {
                $param = (Get-Command $FunctionName).Parameters['LinkID']

                it "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Confirm'
                    $param.ParameterSets.Keys | Should -Contain 'Force'
                    $param.ParameterSets.Confirm.IsMandatory | Should -Be $true
                    $param.ParameterSets.Force.IsMandatory | Should -Be $true
                    $param.ParameterSets.Confirm.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterSets.Force.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'id'
                }
            }

            Context "Force" {
                $param = (Get-Command $FunctionName).Parameters['Force']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Force'
                    $param.ParameterSets.Force.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }

        }
    }
}
