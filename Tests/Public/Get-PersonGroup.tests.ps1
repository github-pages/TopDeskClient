Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-PersonGroup" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-PersonGroup'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-PersonGroup -List } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {
            $script:TDConnected = $true

            Context "GroupID" {
                $pobj1 = [PSCustomObject]@{
                    GroupID = '1'
                }
                $param1 = $pobj1.GroupID
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/persongroups/id/' + $param1 } -Verifiable
                $pobj1 | Get-PersonGroup

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            $param1 = '1'

            Context "GroupID" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/persongroups/id/' + $param1 } -Verifiable
                Get-PersonGroup -GroupID $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "LIst" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/persongroups/lookup?$all=true' } -Verifiable
                Get-PersonGroup -List

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Parameters" {
            
            Context "GroupID" {
                $param = (Get-Command $FunctionName).Parameters['GroupID']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'Details'
                    $param.ParameterSets.Details.IsMandatory | Should -Be $true
                    $param.ParameterSets.Details.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                    $param.Aliases | Should -Contain 'ID'
                }
            }

            Context "List" {
                $param = (Get-Command $FunctionName).Parameters['List']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'List'
                    $param.ParameterSets.List.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }

        }
    }
}