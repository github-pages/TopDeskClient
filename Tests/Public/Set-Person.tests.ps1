Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Set-Person" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Set-Person'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Set-Person -PersonID 'A1234567-4444-4444-4444-121212121212' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
        }

        Context "Pipeline input" {
            
            $script:TDConnected = $true
            $param1 = 'A1234567-4444-4444-4444-121212121212'

            $pobj1 = [PSCustomObject]@{
                PersonID = $param1
                SurName = 'Test'
                FirstName = 'TestFirst'
                Email = 'test@mytest.domain'
            }
            $body = @{
               Surname = 'Test'
               FirstName = 'TestFirst'
               Email = 'test@mytest.domain'
            }
            $baseURI = '/tas/api/persons' + $param1

            Context "Person" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                $pobj1 | Set-Person

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            $param1 = 'A1234567-4444-4444-4444-121212121212'
            $param2 = 'Test'
            $param3 = 'TestFirst'
            $param4 = 'test@mytest.domain'
            $body = @{
                Surname = $param2
                FirstName = $param3
                Email = $param4
             }
             $baseURI = '/tas/api/persons' + $param1

             Context "Person" {
                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { $_uri -and $_uri -eq $baseURI; $_body -and $_body -eq (ConvertTo-Json -InputObject $body) } -Verifiable
                Set-Person -PersonID $param1 -surName $param2 -firstName $param3 -email $param4

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

        }

        Context "Parameters" {

            Context "PersonID" {

                $param = (Get-Command $FunctionName).Parameters['PersonID']

                It "Should maintain compatiblity" {

                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'id'
                    
                }

            }

            Context "surName" {

                $param = (Get-Command $FunctionName).Parameters['surName']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'LastName'
                    
                }

            }

            Context "firstName" {

                $param = (Get-Command $FunctionName).Parameters['firstName']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'Name'
                    $param.Aliases | Should -Contain 'GivenName'
                    
                }

            }

            Context "firstInitials" {

                $param = (Get-Command $FunctionName).Parameters['firstInitials']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "prefixes" {

                $param = (Get-Command $FunctionName).Parameters['prefixes']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "gender" {

                $param = (Get-Command $FunctionName).Parameters['gender']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "employeeNumber" {

                $param = (Get-Command $FunctionName).Parameters['employeeNumber']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'EmployeeID'
                    
                }

            }

            Context "networkLoginName" {

                $param = (Get-Command $FunctionName).Parameters['networkLoginName']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'username'
                    
                }

            }

            Context "branch" {

                $param = (Get-Command $FunctionName).Parameters['branch']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "location" {

                $param = (Get-Command $FunctionName).Parameters['location']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "department" {

                $param = (Get-Command $FunctionName).Parameters['department']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'dept'
                    
                }

            }

            Context "language" {

                $param = (Get-Command $FunctionName).Parameters['language']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'lang'
                    
                }

            }

            Context "departmentFree" {

                $param = (Get-Command $FunctionName).Parameters['departmentFree']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "tasLoginName" {

                $param = (Get-Command $FunctionName).Parameters['tasLoginName']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'Login'
                    
                }

            }

            Context "password" {

                $param = (Get-Command $FunctionName).Parameters['password']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'securestring'
                    
                }

            }

            Context "phoneNumber" {

                $param = (Get-Command $FunctionName).Parameters['phoneNumber']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'Phone'
                    
                }

            }

            Context "mobileNumber" {

                $param = (Get-Command $FunctionName).Parameters['mobileNumber']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'cell'
                    $param.Aliases | Should -Contain 'mobile'
                    
                }

            }

            Context "fax" {

                $param = (Get-Command $FunctionName).Parameters['fax']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "email" {

                $param = (Get-Command $FunctionName).Parameters['email']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "jobTitle" {

                $param = (Get-Command $FunctionName).Parameters['jobTitle']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "showBudgetholder" {

                $param = (Get-Command $FunctionName).Parameters['showBudgetholder']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "showDepartment" {

                $param = (Get-Command $FunctionName).Parameters['showDepartment']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "showBranch" {

                $param = (Get-Command $FunctionName).Parameters['showBranch']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "showSubsidiaries" {

                $param = (Get-Command $FunctionName).Parameters['showSubsidiaries']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "showAllBranches" {

                $param = (Get-Command $FunctionName).Parameters['showAllBranches']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "authorizeAll" {

                $param = (Get-Command $FunctionName).Parameters['authorizeAll']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "authorizeDepartment" {

                $param = (Get-Command $FunctionName).Parameters['authorizeDepartment']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "authorizeBudgetHolder" {

                $param = (Get-Command $FunctionName).Parameters['authorizeBudgetHolder']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "authorizeBranch" {

                $param = (Get-Command $FunctionName).Parameters['authorizeBranch']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "authorizeSubsidiaryBranches" {

                $param = (Get-Command $FunctionName).Parameters['authorizeSubsidiaryBranches']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "optionalFields1" {

                $param = (Get-Command $FunctionName).Parameters['optionalFields1']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'psobject'
                    
                }

            }

            Context "optionalFields2" {

                $param = (Get-Command $FunctionName).Parameters['optionalFields2']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'psobject'
                    
                }

            }

            Context "budgetHolder" {

                $param = (Get-Command $FunctionName).Parameters['budgetHolder']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

            Context "personExtraFieldA" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldA']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                    
                }

            }

            Context "personExtraFieldB" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldB']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                    
                }

            }

            Context "isManager" {

                $param = (Get-Command $FunctionName).Parameters['isManager']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                    
                }

            }

            Context "manager" {

                $param = (Get-Command $FunctionName).Parameters['manager']

                It "Should maintain compatiblity" {
                    
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    
                }

            }

        }

    }
}