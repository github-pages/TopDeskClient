Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "New-Incident" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'New-Incident'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { New-Incident -callerLookupEmail 'test@test.testing' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Pipeline input" {
            $script:TDConnected = $true

        }

        Context "Calling with parameters" {
            
            $script:TDConnected = $true

        }

        Context "Parameters" {

            Context "callerLookupEmail" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupEmail']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $true
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "callerLookupID" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupID']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $true
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "callerLookupEmployeeNumber" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupEmployeeNumber']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $true
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "callerLookupNetworkLoginName" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupNetworkLoginName']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $true
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "callerLookupLoginName" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupLoginName']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $true
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "dynamicName" {

                $param = (Get-Command $FunctionName).Parameters['dynamicName']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $true
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "branchID" {

                $param = (Get-Command $FunctionName).Parameters['branchID']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

        }
    }
}