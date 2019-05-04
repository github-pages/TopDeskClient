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

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $true
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "callerLookupEmployeeNumber" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupEmployeeNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $true
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $true
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "callerLookupNetworkLoginName" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupNetworkLoginName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $true
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $true
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "callerLookupLoginName" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupLoginName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $true
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $true
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "dynamicName" {

                $param = (Get-Command $FunctionName).Parameters['dynamicName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $true
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $true
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "branchID" {

                $param = (Get-Command $FunctionName).Parameters['branchID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "phoneNumber" {

                $param = (Get-Command $FunctionName).Parameters['phoneNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "mobileNumber" {

                $param = (Get-Command $FunctionName).Parameters['mobileNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "email" {

                $param = (Get-Command $FunctionName).Parameters['email']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "departmentID" {

                $param = (Get-Command $FunctionName).Parameters['departmentID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "locationID" {

                $param = (Get-Command $FunctionName).Parameters['locationID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "budgetHolderID" {

                $param = (Get-Command $FunctionName).Parameters['budgetHolderID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldAID" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldAID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldBID" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldBID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.UnregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.UnregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "status" {

                $param = (Get-Command $FunctionName).Parameters['status']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "briefDescription" {

                $param = (Get-Command $FunctionName).Parameters['briefDescription']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "request" {

                $param = (Get-Command $FunctionName).Parameters['request']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "action" {

                $param = (Get-Command $FunctionName).Parameters['action']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "actionInvisibleForCaller" {

                $param = (Get-Command $FunctionName).Parameters['actionInvisibleForCaller']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "entryTypeID" {

                $param = (Get-Command $FunctionName).Parameters['entryTypeID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "callTypeID" {

                $param = (Get-Command $FunctionName).Parameters['callTypeID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "categoryID" {

                $param = (Get-Command $FunctionName).Parameters['categoryID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "categoryName" {

                $param = (Get-Command $FunctionName).Parameters['categoryName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "subcategoryID" {

                $param = (Get-Command $FunctionName).Parameters['subcategoryID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "subcategoryName" {

                $param = (Get-Command $FunctionName).Parameters['subcategoryName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "externalNumber" {

                $param = (Get-Command $FunctionName).Parameters['externalNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "mainIncidentID" {

                $param = (Get-Command $FunctionName).Parameters['mainIncidentID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "objectID" {

                $param = (Get-Command $FunctionName).Parameters['objectID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "objectName" {

                $param = (Get-Command $FunctionName).Parameters['objectName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "objectLocationID" {

                $param = (Get-Command $FunctionName).Parameters['objectLocationID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "impactID" {

                $param = (Get-Command $FunctionName).Parameters['impactID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "urgencyID" {

                $param = (Get-Command $FunctionName).Parameters['urgencyID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "priorityID" {

                $param = (Get-Command $FunctionName).Parameters['priorityID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "durationID" {

                $param = (Get-Command $FunctionName).Parameters['durationID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "targetDate" {

                $param = (Get-Command $FunctionName).Parameters['targetDate']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

            Context "slaID" {

                $param = (Get-Command $FunctionName).Parameters['slaID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "onHold" {

                $param = (Get-Command $FunctionName).Parameters['onHold']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "operatorID" {

                $param = (Get-Command $FunctionName).Parameters['operatorID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "operatorGroupID" {

                $param = (Get-Command $FunctionName).Parameters['operatorGroupID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "supplierID" {

                $param = (Get-Command $FunctionName).Parameters['supplierID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "processingStatusID" {

                $param = (Get-Command $FunctionName).Parameters['processingStatusID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "responded" {

                $param = (Get-Command $FunctionName).Parameters['responded']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "responseDate" {

                $param = (Get-Command $FunctionName).Parameters['responseDate']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

            Context "completed" {

                $param = (Get-Command $FunctionName).Parameters['completed']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "completedDate" {

                $param = (Get-Command $FunctionName).Parameters['completedDate']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

            Context "closed" {

                $param = (Get-Command $FunctionName).Parameters['closed']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "closedDate" {

                $param = (Get-Command $FunctionName).Parameters['closedDate']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

            Context "closureCodeID" {

                $param = (Get-Command $FunctionName).Parameters['closureCodeID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "costs" {

                $param = (Get-Command $FunctionName).Parameters['costs']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'single'

                }
            }

            Context "feedbackRating" {

                $param = (Get-Command $FunctionName).Parameters['feedbackRating']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'int32'

                }
            }

            Context "feedbackMessage" {

                $param = (Get-Command $FunctionName).Parameters['feedbackMessage']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "majorCall" {

                $param = (Get-Command $FunctionName).Parameters['majorCall']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'switchparameter'

                }
            }

            Context "majorCallObjectID" {

                $param = (Get-Command $FunctionName).Parameters['majorCallObjectID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "publishToSsd" {

                $param = (Get-Command $FunctionName).Parameters['publishToSsd']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "freeFields1" {

                $param = (Get-Command $FunctionName).Parameters['freeFields1']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'PSObject'
                    
                }
            }

            Context "freeFields2" {

                $param = (Get-Command $FunctionName).Parameters['freeFields2']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'PSObject'

                }
            }

            Context "externalLinkID" {

                $param = (Get-Command $FunctionName).Parameters['externalLinkID']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "externalLinkType" {

                $param = (Get-Command $FunctionName).Parameters['externalLinkType']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'int32'

                }
            }

            Context "externalLinkDate" {

                $param = (Get-Command $FunctionName).Parameters['externalLinkDate']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'byID'
                    $param.ParameterSets.byID.IsMandatory | Should -Be $false
                    $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployee'
                    $param.ParameterSets.byEmployee.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployee.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetwork'
                    $param.ParameterSets.byNetwork.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetwork.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLogin'
                    $param.ParameterSets.byLogin.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLogin.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byIDMajor'
                    $param.ParameterSets.byIDMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byIDMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmailMajor'
                    $param.ParameterSets.byEmailMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmailMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byEmployeeMajor'
                    $param.ParameterSets.byEmployeeMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byEmployeeMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byNetworkMajor'
                    $param.ParameterSets.byNetworkMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNetworkMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'byLoginMajor'
                    $param.ParameterSets.byLoginMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.byLoginMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterSets.Keys | Should -Contain 'unregisteredMajor'
                    $param.ParameterSets.unregisteredMajor.IsMandatory | Should -Be $false
                    $param.ParameterSets.unregisteredMajor.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

        }
    }
}