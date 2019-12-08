Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe New-Person {
InModuleScope -ModuleName TopDeskClient {

    $FunctionName = 'New-Person'
    Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

    Context "Connection state" {

        It "Should throw when client is disconnected" {
            $script:TDConnected = $false
            { New-Person -surName 'test' } | Should -Throw
        }

        It "Should NOT have performed any API calls" {
            Assert-MockCalled -CommandName Get-APIResponse -Times 0
        }
    }

    Context "Pipeline Input" {

        $script:TDConnected = $true
        $baseURI = '/tas/api/persons/'

        Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter {$_uri -eq $baseURI -and ($_body -like '*"surName":"test"*')} -Verifiable

        It "Should perform an API call" {
            [PSCustomObject]@{
                surName       = 'test'
            } | New-Person | Should -Be $null
            Assert-VerifiableMock
        }

        It "Should perform an API call - password" {
            $password = ConvertTo-SecureString -String 'testpassword' -AsPlainText -Force
            [PSCustomObject]@{
                surName = 'test'
                password = $password
            } | New-Person | Should -Be $null
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
                    (Get-Command $FunctionName).DefaultParameterSet | Should -Be 'Default'
                }
                It "Should have 35 parameters in the default set" {
                    (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Count | Should -Be 48
                }
            }
        }

        Context "Mandatory Parameters" {
            It "surName should be mandatory" {
                Get-Command $FunctionName | Should -HaveParameter -ParameterName 'surName' -Type [string] -Mandatory
            }
        }

        Context "Parameter Compatibility" {

            Context "surName" {

                $param = (Get-Command $FunctionName).Parameters['surName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "firstName" {

                $param = (Get-Command $FunctionName).Parameters['firstName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "firstInitials" {

                $param = (Get-Command $FunctionName).Parameters['firstInitials']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "prefixes" {

                $param = (Get-Command $FunctionName).Parameters['prefixes']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "birthName" {

                $param = (Get-Command $FunctionName).Parameters['birthName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "gender" {

                $param = (Get-Command $FunctionName).Parameters['gender']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "employeeNumber" {

                $param = (Get-Command $FunctionName).Parameters['employeeNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "networkLoginName" {

                $param = (Get-Command $FunctionName).Parameters['networkLoginName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "branch" {

                $param = (Get-Command $FunctionName).Parameters['branch']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "location" {

                $param = (Get-Command $FunctionName).Parameters['location']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "department" {

                $param = (Get-Command $FunctionName).Parameters['department']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "longuage" {

                $param = (Get-Command $FunctionName).Parameters['language']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "departmentFree" {

                $param = (Get-Command $FunctionName).Parameters['departmentFree']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "tasLoginName" {

                $param = (Get-Command $FunctionName).Parameters['tasLoginName']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "password" {

                $param = (Get-Command $FunctionName).Parameters['password']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'securestring'

                }
            }

            Context "phoneNumber" {

                $param = (Get-Command $FunctionName).Parameters['phoneNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "mobileNumber" {

                $param = (Get-Command $FunctionName).Parameters['mobileNumber']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "fax" {

                $param = (Get-Command $FunctionName).Parameters['fax']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "email" {

                $param = (Get-Command $FunctionName).Parameters['email']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "jobTitle" {

                $param = (Get-Command $FunctionName).Parameters['jobTitle']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "showBudgetHolder" {

                $param = (Get-Command $FunctionName).Parameters['showBudgetHolder']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "showDepartment" {

                $param = (Get-Command $FunctionName).Parameters['showDepartment']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "showBranch" {

                $param = (Get-Command $FunctionName).Parameters['showBranch']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "showSubsidiaries" {

                $param = (Get-Command $FunctionName).Parameters['showSubsidiaries']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "showAllBranches" {

                $param = (Get-Command $FunctionName).Parameters['showAllBranches']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "authorizeAll" {

                $param = (Get-Command $FunctionName).Parameters['authorizeAll']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "authorizeBudgetHolder" {

                $param = (Get-Command $FunctionName).Parameters['authorizeBudgetHolder']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "authorizeBranch" {

                $param = (Get-Command $FunctionName).Parameters['authorizeBranch']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "authorizeSubsidiaryBranches" {

                $param = (Get-Command $FunctionName).Parameters['authorizeSubsidiaryBranches']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "budgetHolder" {

                $param = (Get-Command $FunctionName).Parameters['budgetHolder']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldA" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldA']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "personExtraFieldB" {

                $param = (Get-Command $FunctionName).Parameters['personExtraFieldB']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "isManager" {

                $param = (Get-Command $FunctionName).Parameters['isManager']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'Boolean'

                }
            }

            Context "manager" {

                $param = (Get-Command $FunctionName).Parameters['manager']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }
        }

        <# Context "Parameter Alias" {
            Context "Name" {
                It "Should have an alias ComputerName" {
                    (Get-Command $FunctionName).Parameters['Name'].Aliases.Contains('ComputerName') | Should -Be $true
                }
            }
        } #>
    }

    }
}
