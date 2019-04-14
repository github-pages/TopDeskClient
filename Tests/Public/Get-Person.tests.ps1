Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Person" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Person'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }
    
        Context "Connection state" {
            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Person -PersonID '1' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
        }

        Context "Pipeline input" {
            $script:TDConnected = $true
            $uriPerson = '/tas/api/persons/id/'
            $uriSSP = '/tas/api/persons?ssp_login_name='
            $uriNetwork = '/tas/api/persons?network_login_name='
            $uriEmail = '/tas/api/persons?email='
            $uriLastName = '/tas/api/persons?lastname='
            $uriFirstName = '/tas/api/persons?firstname='

            Context "by PersonID" {

                $pobj1 = [PSCustomObject]@{
                    PersonID = '1'
                }
                $param1 = $pobj1.PersonID
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 } -Verifiable
                $pobj1 | Get-Person

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "by SSPLogin" {

                $pobj1 = [PSCustomObject]@{
                    SSPLoginName = '1'
                }
                $param1 = $pobj1.SSPLoginName
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriSSP + $param1 } -Verifiable
                $pobj1 | Get-Person

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "by NetworkLogin" {

                $pobj1 = [PSCustomObject]@{
                    NetworkLoginName = '1'
                }
                $param1 = $pobj1.NetworkLoginName
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriNetwork + $param1 } -Verifiable
                $pobj1 | Get-Person

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "by Email" {

                $pobj1 = [PSCustomObject]@{
                    Email = '1'
                }
                $param1 = $pobj1.Email
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriEmail + $param1 } -Verifiable
                $pobj1 | Get-Person

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "by LastName" {

                $pobj1 = [PSCustomObject]@{
                    LastName = '1'
                }
                $param1 = $pobj1.LastName
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriLastName + $param1 } -Verifiable
                $pobj1 | Get-Person

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "by FirstName" {

                $pobj1 = [PSCustomObject]@{
                    FirstName = '1'
                }
                $param1 = $pobj1.FirstName
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriFirstName + $param1 } -Verifiable
                $pobj1 | Get-Person

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Archived" {

                Context "PersonID false" {
                    $pobjPerson = [PSCustomObject]@{
                        PersonID = 'MyPersonID'
                        Archived = $false
                    }
                    $param1 = $pobjPerson.PersonID
                    $param2 = $pobjPerson.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 }
                    }
                    $pobjPerson | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriPerson + $param1 + '&archived=' + $param2 )} -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriPerson + $param1)} -Times 1 -Exactly
                        }
                    }
                }

                Context "SSPLogin" {
                    $pobjSSP = [PSCustomObject]@{
                        SSPLoginName = 'MySSPLogin'
                        Archived = $true
                    }
                    $param1 = $pobjSSP.SSPLoginName
                    $param2 = $pobjSSP.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriSSP + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriSSP + $param1 }
                    }
                    $pobjSSP | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriSSP + $param1 + '&archived=' + $param2 )} -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriSSP + $param1)} -Times 1 -Exactly
                        }
                    }
                }

                Context "NetworkLogin" {
                    $pobjNetwork = [PSCustomObject]@{
                        NetworkLoginName = 'MyLoginName'
                        Archived = $true
                    }
                    $param1 = $pobjNetwork.NetworkLoginName
                    $param2 = $pobjNetwork.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriNetwork + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriNetwork + $param1 }
                    }
                    $pobjNetwork | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriNetwork + $param1 + '&archived=' + $param2 )} -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriNetwork + $param1)} -Times 1 -Exactly
                        }
                    }
                }

                Context "Email" {
                    $pobjEmail = [PSCustomObject]@{
                        Email = 'My@Email.address'
                        Archived = $true
                    }
                    $param1 = $pobjEmail.Email
                    $param2 = $pobjEmail.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriEmail + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriEmail + $param1 }
                    }
                    $pobjEmail | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriEmail + $param1 + '&archived=' + $param2 )} -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriEmail + $param1)} -Times 1 -Exactly
                        }
                    }
                }

                Context "LastName" {
                    $pobjLastName = [PSCustomObject]@{
                        LastName = 'MyLastName'
                        Archived = $true
                    }
                    $param1 = $pobjLastName.LastName
                    $param2 = $pobjLastName.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriLastName + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriLastName + $param1 }
                    }
                    $pobjLastName | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriLastName + $param1 + '&archived=' + $param2 )} -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriLastName + $param1)} -Times 1 -Exactly
                        }
                    }
                }

                Context "FirstName" {
                    $pobjFirstName = [PSCustomObject]@{
                        FirstName = 'MyFirstName'
                        Archived = $true
                    }
                    $param1 = $pobjFirstName.FirstName
                    $param2 = $pobjFirstName.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriFirstName + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriFirstName + $param1 }
                    }
                    $pobjFirstName | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriFirstName + $param1 + '&archived=' + $param2 )} -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq ($uriFirstName + $param1)} -Times 1 -Exactly
                        }
                    }
                }

                Context "PersonID" {
                    $pobjPersonf = [PSCustomObject]@{
                        PersonID = 'MyPersonID'
                        Archived = $true
                    }
                    $param1 = $pobjPersonf.PersonID
                    $param2 = $pobjPersonf.Archived
                    if($param2) {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 + '&archived=' + $param2 }
                    }
                    else {
                        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 }
                    }
                    $pobjPersonf | Get-Person

                    It "Should perform 1 API call" {
                        if($param2) {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq $uriPerson + $param1 + '&archived=' + $param2 } -Times 1 -Exactly
                        }
                        else {
                            Assert-MockCalled -CommandName Get-APIResponse -ParameterFilter { $APIUrl -eq $uriPerson + $param1 } -Times 1 -Exactly
                        }
                    }
                }

            }

        }

        Context "Calling with parameters" {

            $script:TDConnected = $true
            $uriPerson = '/tas/api/persons/id/'
            $uriSSP = '/tas/api/persons?ssp_login_name='
            $uriNetwork = '/tas/api/persons?network_login_name='
            $uriEmail = '/tas/api/persons?email='
            $uriLastName = '/tas/api/persons?lastname='
            $uriFirstName = '/tas/api/persons?firstname='
            $param1 = 'MyTest'

            Context "PersonID" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 } -Verifiable
                Get-Person -PersonID $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "SSPLogin" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriSSP + $param1 } -Verifiable
                Get-Person -SSPLoginName $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "NetworkLogin" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriNetwork + $param1 } -Verifiable
                Get-Person -NetworkLoginName $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Email" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriEmail + $param1 } -Verifiable
                Get-Person -Email $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "LastName" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriLastName + $param1 } -Verifiable
                Get-Person -LastName $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "FirstName" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriFirstName + $param1 } -Verifiable
                Get-Person -FirstName $param1

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "PersonID Archived" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $uriPerson + $param1 + '&archived=True' } -Verifiable
                Get-Person -PersonID $param1 -Archived $true

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Parameters" {

            Context "PersonID" {
                $param = (Get-Command $FunctionName).Parameters['PersonID']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Simple'
                    $param.ParameterSets.Simple.IsMandatory | Should -Be $true
                    $param.ParameterSets.Simple.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                    $param.Aliases | Should -Contain 'unid'
                    $param.Aliases | Should -Contain 'ID'
                }
            }

            Context "List" {
                $param = (Get-Command $FunctionName).Parameters['List']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'List'
                    $param.ParameterSets.List.IsMandatory | Should -Be $true
                    $param.ParameterSets.List.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'switchParameter'
                }
            }

            Context "SSPLoginName" {
                $param = (Get-Command $FunctionName).Parameters['SSPLoginName']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'BySSP'
                    $param.ParameterSets.BySSP.IsMandatory | Should -Be $true
                    $param.ParameterSets.BySSP.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "NetworkLoginName" {
                $param = (Get-Command $FunctionName).Parameters['NetworkLoginName']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByNetworkLogin'
                    $param.ParameterSets.ByNetworkLogin.IsMandatory | Should -Be $true
                    $param.ParameterSets.ByNetworkLogin.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "Email" {
                $param = (Get-Command $FunctionName).Parameters['Email']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByEmail'
                    $param.ParameterSets.ByEmail.IsMandatory | Should -Be $true
                    $param.ParameterSets.ByEmail.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "LastName" {
                $param = (Get-Command $FunctionName).Parameters['LastName']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByLastName'
                    $param.ParameterSets.ByLastName.IsMandatory | Should -Be $true
                    $param.ParameterSets.ByLastName.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "FirstName" {
                $param = (Get-Command $FunctionName).Parameters['FirstName']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByFirstName'
                    $param.ParameterSets.ByFirstName.IsMandatory | Should -Be $true
                    $param.ParameterSets.ByFirstName.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "Archived" {
                $param = (Get-Command $FunctionName).Parameters['Archived']
                
                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParameterSets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'Archived' -DefaultValue $false
                }
            }
        }

    }
}
