Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "New-MajorIncident" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'New-MajorIncident'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { New-MajorIncident -callerLookupEmail 'test@test.testing' } | Should -Throw
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

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $true
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "branch" {

                $param = (Get-Command $FunctionName).Parameters['branch']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "phoneNumber" {

                $param = (Get-Command $FunctionName).Parameters['phoneNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "mobileNumber" {

                $param = (Get-Command $FunctionName).Parameters['mobileNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "email" {

                $param = (Get-Command $FunctionName).Parameters['email']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "department" {

                $param = (Get-Command $FunctionName).Parameters['department']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "location" {

                $param = (Get-Command $FunctionName).Parameters['location']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "budgetHolder" {

                $param = (Get-Command $FunctionName).Parameters['budgetHolder']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldA" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldA']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldB" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldB']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false
                    
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

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "entryType" {

                $param = (Get-Command $FunctionName).Parameters['entryType']

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

            Context "callType" {

                $param = (Get-Command $FunctionName).Parameters['callType']

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

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "impact" {

                $param = (Get-Command $FunctionName).Parameters['impact']

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

            Context "urgency" {

                $param = (Get-Command $FunctionName).Parameters['urgency']

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

            Context "priority" {

                $param = (Get-Command $FunctionName).Parameters['priority']

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

            Context "duration" {

                $param = (Get-Command $FunctionName).Parameters['duration']

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

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

            Context "sla" {

                $param = (Get-Command $FunctionName).Parameters['sla']

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

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "operator" {

                $param = (Get-Command $FunctionName).Parameters['operator']

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

            Context "operatorGroup" {

                $param = (Get-Command $FunctionName).Parameters['operatorGroup']

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

            Context "supplier" {

                $param = (Get-Command $FunctionName).Parameters['supplier']

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

            Context "processingStatus" {

                $param = (Get-Command $FunctionName).Parameters['processingStatus']

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

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

            Context "closureCode" {

                $param = (Get-Command $FunctionName).Parameters['closureCode']

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

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "publishToSsd" {

                $param = (Get-Command $FunctionName).Parameters['publishToSsd']

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

                    $param.ParameterType.Name | Should -Be 'boolean'

                }
            }

            Context "optionalFields1" {

                $param = (Get-Command $FunctionName).Parameters['optionalFields1']

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

                    $param.ParameterType.Name | Should -Be 'hashtable'
                    
                }
            }

            Context "optionalFields2" {

                $param = (Get-Command $FunctionName).Parameters['optionalFields2']

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

                    $param.ParameterType.Name | Should -Be 'hashtable'

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

                    $param.ParameterType.Name | Should -Be 'datetime'

                }
            }

        }
    }
}