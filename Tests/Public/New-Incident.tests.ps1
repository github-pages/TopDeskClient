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
            #N/A
        }

        Context "Calling with parameters" {

            $script:TDConnected = $true
            $param1 = 'A1234567-4444-4444-4444-121212121212'
            $param2 = 'secondLine'
            $param3 = 'myoperator@mytest.test'
            $baseURI = '/tas/api/incidents/'

            Context "CallerbyID" {

                $body = @{
                    'callerLookup' = @{ 'id' = $param1 }
                    'status' = $param2
                }
                $jsonbody = (ConvertTo-Json -InputObject $body -Depth 8 -Compress)

                #Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -eq '/tas/api/incidents/'  -and $_body -eq '{"callerLookup":{"id":"A1234567-4444-4444-4444-121212121212"},"status":"secondLine"}' ) } -Verifiable
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -and $_uri -eq $baseURI) -and ($_body -and $_body -eq $jsonbody ) } -Verifiable
                $result = New-Incident -callerLookupID $param1 -status $param2

                It "Should perform an API call" {
                    Assert-VerifiableMock
                    $result | Should -Be $null
                }
            }

            Context "CallerbyEmail" {

                $body = @{
                    'callerLookup' = @{ 'email' = $param3 }
                    'status' = $param2
                    'briefDescription' = 'By email test'
                }
                $jsonbody = (ConvertTo-Json -InputObject $body -Depth 8 -Compress)

                #Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and '/tas/api/incidents/' -eq $baseURI;  $_body -and $_body -eq '{"status":"secondLine","briefDescription":"By email test","callerLookup":{"email":"myoperator@mytest.test"}}' } -Verifiable
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -and $_uri -eq $baseURI) -and ($_body -and $_body -eq $jsonbody ) } -Verifiable
                $result = New-Incident -callerLookupEmail $param3 -status $param2

                It "Should perform an API call" {
                    Assert-VerifiableMock
                    $result | Should -Be $null
                }
            }

            Context "CallerbyEmployeeNumber" {

                $body = @{
                    'callerLookup' = @{ 'employeeNumber' = '1234567' }
                    'status' = 'firstline'
                    'externalNumber' = '131313'
                }
                $jsonbody = (ConvertTo-Json -InputObject $body -Depth 8 -Compress)

                #Mock -CommandName Get-APIResponse -MockWith {} -ParameterFilter { ($_uri -eq $baseURI) -and ($_body -eq '{"callerLookup":{"employeeNumber":"1234567"},"status":"firstline","externalNumber":"131313"}') } -Verifiable
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -and $_uri -eq $baseURI) -and ($_body -and $_body -eq $jsonbody ) } -Verifiable
                $result = New-Incident -callerLookupEmployeeNumber 1234567 -status 'firstline' -externalNumber '131313'

                It "Should perform an API call" {
                    Assert-VerifiableMock
                    $result | Should -be $null
                }
            }

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

            Context "departmentId" {

                $param = (Get-Command $FunctionName).Parameters['departmentId']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "departmentName" {

                $param = (Get-Command $FunctionName).Parameters['departmentName']

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

            Context "budgetHolderId" {

                $param = (Get-Command $FunctionName).Parameters['budgetHolderId']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "budgetHolderName" {

                $param = (Get-Command $FunctionName).Parameters['budgetHolderName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldAId" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldAId']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldAName" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldAName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldBId" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldBId']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'unregistered'
                    $param.ParameterSets.Unregistered.IsMandatory | Should -Be $false
                    $param.ParameterSets.Unregistered.ValueFromPipelineByPropertyName | Should -Be $false

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldBName" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldBName']

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

            Context "entryTypeId" {

                $param = (Get-Command $FunctionName).Parameters['entryTypeId']

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

            Context "entryTypeName" {

                $param = (Get-Command $FunctionName).Parameters['entryTypeName']

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

            Context "callTypeId" {

                $param = (Get-Command $FunctionName).Parameters['callTypeId']

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

            Context "callTypeName" {

                $param = (Get-Command $FunctionName).Parameters['callTypeName']

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

            Context "impactId" {

                $param = (Get-Command $FunctionName).Parameters['impactId']

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

            Context "impactName" {

                $param = (Get-Command $FunctionName).Parameters['impactName']

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

            Context "urgencyId" {

                $param = (Get-Command $FunctionName).Parameters['urgencyId']

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

            Context "urgencyName" {

                $param = (Get-Command $FunctionName).Parameters['urgencyName']

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

            Context "priorityId" {

                $param = (Get-Command $FunctionName).Parameters['priorityId']

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

            Context "priorityName" {

                $param = (Get-Command $FunctionName).Parameters['priorityName']

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

            Context "durationId" {

                $param = (Get-Command $FunctionName).Parameters['durationId']

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

            Context "durationName" {

                $param = (Get-Command $FunctionName).Parameters['durationName']

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

            Context "processingStatusId" {

                $param = (Get-Command $FunctionName).Parameters['processingStatusId']

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

            Context "processingStatusName" {

                $param = (Get-Command $FunctionName).Parameters['processingStatusName']

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

            Context "closureCodeId" {

                $param = (Get-Command $FunctionName).Parameters['closureCodeId']

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

            Context "closureCodeName" {

                $param = (Get-Command $FunctionName).Parameters['closureCodeName']

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

            Context "majorCallObject" {

                $param = (Get-Command $FunctionName).Parameters['majorCallObject']

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