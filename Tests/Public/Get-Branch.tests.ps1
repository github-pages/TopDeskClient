Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Branch" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Branch'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Branch -List } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {

            $script:TDConnected = $true

            Context "Branch by ID" {
                $pobj1 = [PSCustomObject]@{
                    BranchID = '12341234-1234-1234-1234-1234567890AB'
                }
                $param1 = $pobj1.BranchID
                Mock -CommandName Get-APIResponse -MockWith { return 'Branch by ID' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/branches/id/' + $param1 } -Verifiable
                $Branch = ($pobj1 | Get-Branch)

                It "Should retrieve a branch by ID" {
                    $Branch | Should -Not -BeNullOrEmpty
                    $Branch | Should -Be 'Branch by ID'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Branch by Name" {
                $pobj1 = [PSCustomObject]@{
                    BranchName = 'MyBranch'
                }
                $param1 = $pobj1.BranchName
                Mock -CommandName Get-APIResponse -MockWith { return 'Branch by Name' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/branches?nameFragment=' + $param1.Trim()}
                $Branch = ($pobj1 | Get-Branch)

                It "Should retrieve a branch by Name" {
                    $Branch | Should -Not -BeNullOrEmpty
                    $Branch | Should -Be 'Branch by Name'
                }

                it "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true

            Context "Get Branch by ID" {
                $param1 = '12341234-1234-1234-1234-1234567890AB'
                Mock -CommandName Get-APIResponse -MockWith { return 'Branch by ID' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/branches/id/' + $param1 } -Verifiable
                $Branch = (Get-Branch -BranchID $param1)

                It "Should retrieve a branch by ID" {
                    $Branch | Should -Not -BeNullOrEmpty
                    $Branch | Should -Be 'Branch by ID'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Get Branch by Name" {
                $param1 = 'MyBranch'
                Mock -CommandName Get-APIResponse -MockWith { return 'Branch by Name' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/branches?nameFragment=' + $param1.Trim()}
                $Branch = (Get-Branch -BranchName $param1)

                It "Should retrieve a branch by Name" {
                    $Branch | Should -Not -BeNullOrEmpty
                    $Branch | Should -Be 'Branch by Name'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Get Branch LIst" {
                Mock -CommandName Get-APIResponse -MockWith { return 'BranchList' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/branches' } -Verifiable
                $Branch = (Get-Branch -List)

                It "Should retrieve a branch list" {
                    $Branch | Should -Not -BeNullOrEmpty
                    $Branch | Should -Be 'BranchList'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Parameters" {

            Context "ParameterSets" {

                Context "Details" {
                    It "Should have a parameterset named Details " {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Details' | Should -Be $true
                    }

                    It "Should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Details' }).IsDefault | Should -Be $true
                    }

                    It "Should have 1 parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Details' }).Parameters.Name | Should -Contain 'BranchID'
                    }
                }

                Context "List" {
                    It "Should have a parameterset named List " {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'List' | Should -Be $true
                    }

                    It "Should have 1 parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'List' }).Parameters.Name | Should -Contain 'List'
                    }
                }

                Context "BranchName" {
                    It "Should have a parameterset named BranchName " {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'BranchName' | Should -Be $true
                    }

                    It "Should have 1 parameter" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'BranchName' }).Parameters.Name | Should -Contain 'BranchName'
                    }
                }
            }

            Context "Mandatory Parameters" {
                
                It "BranchID should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'BranchID' -Mandatory
                }

                It "BranchName should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'BranchName' -Mandatory
                }

                It "List should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'List' -Mandatory
                }
            }

            Context "Parameter Validation" {

                It "BranchID should have 2 alias id unid" {
                    (Get-Command $FunctionName).Parameters['BranchID'].Aliases.Contains('id') | Should -Be $true
                    (Get-Command $FunctionName).Parameters['BranchID'].Aliases.Contains('unid') | Should -Be $true
                }

                It "BranchName should have an alias name" {
                    (Get-Command $FunctionName).Parameters['BranchName'].Aliases.Contains('name') | Should -Be $true
                }
                
            }
        }
    }
}