Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-ArchiveReason" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-ArchiveReason'
        
        $ArchiveReasons = @(
            [PSCustomObject]@{
                name = 'Not current'
                id = '40fa4bd0-a3e3-4ea5-a4d6-c2458a11f793'
            },
            [PSCustomObject]@{
                name = 'written off'
                id = '55509351-2bd5-4588-bd3c-5f20780bb0b4'
            }
        )
        

        Mock -CommandName  Get-APIResponse -MockWith {return $ArchiveReasons }

        Context "Connection state" {

            It "Should throw when client is disconnected" {

                $script:TDConnected = $false
                { Get-ArchiveReason -All } | Should -Throw
                
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {

            $ReasonName = [PSCustomObject]@{
                ReasonName = 'written off'
            }
            Mock -CommandName  Get-APIResponse -MockWith {return $ArchiveReasons | Where-Object {$_.name -eq $ReasonName} }
            $script:TDConnected = $true
            $Reason = ($ReasonName | Get-ArchiveReason)

            It "Returns a value when piped a ReasonName" {
                $Reason | Should -Not -BeNullOrEmpty
            }

            It "Returns only 1 object" {
                $Reason | Should -HaveCount 1
            }

            It "Returns the id matching the ReasonName piped" {
                $Reason | Should -BeExactly '55509351-2bd5-4588-bd3c-5f20780bb0b4'
            }

            It "Performs 1 API call" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
            }

        }

        Context "Calling with params" {

            $script:TDConnected = $true
            $Reasons = Get-ArchiveReason -All
            
            It "Returns a value when called with -All" {
                $Reasons | Should -Not -BeNullOrEmpty
            }

            It "Returns All reasons" {
                $Reasons | Should -HaveCount 2
            }

            $Reason = Get-ArchiveReason -ReasonName 'written off'

            It "Returns a value when called with -ReasonName" {
                $Reason | Should -Not -BeNullOrEmpty
            }

            It "Returns a single result" {
                $Reason | Should -HaveCount 1
            }

            It "Returns the id matching the requested reason" {
                $Reason | Should -BeExactly '55509351-2bd5-4588-bd3c-5f20780bb0b4'
            }

            It "Performs 2 API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 2 -Exactly
            }

        }

        Context "Parameters" {

            Context "ParameterSets" {
                
                Context "Default" {

                    It "Should have a parameterset named Default" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Default' | Should -Be $true
                    }

                    It "Default should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).IsDefault | Should -Be $true
                    }

                    It "Should have 1 parameter in Default" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'All'
                    }

                }

                Context "ByName" {

                    It "Should have a parameterset name ByName" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'ByName' | Should -Be $true
                    }

                    It "Should have 1 parameter in ByName" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'ByName'}).Parameters.Name | Should -Contain 'ReasonName'
                    }

                }

            }

            Context "Mandatory parameters" {

                It "All should NOT be mandatory" {
                    #((Get-Command $FunctionName).Parameters['AssetID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName All -Not -Mandatory
                }

                It "ReasonName should be mandatory" {
                    #((Get-Command $FunctionName).Parameters['TargetID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName ReasonName -Mandatory
                }

            }

            Context "Parameter Validation" {
            
                Context "All" {

                    It "Should accept switch" {
                        #(Get-Command $FunctionName).Parameters['AssetID'].ParameterType.Name | Should -Be String[]
                        Get-Command $FunctionName | Should -HaveParameter -ParameterName All -Type [switch]
                    }
    
                }
    
                Context "ReasonName" {
    
                    It "Should accept a string" {
                        #(Get-Command $FunctionName).Parameters['TargetID'].ParameterType.Name | Should -Be String
                        Get-Command $FunctionName | Should -HaveParameter -ParameterName ReasonName -Type [string]
                    }
    
                    It "Should have an alias Name" {
                        (Get-Command $FunctionName).Parameters['ReasonName'].Aliases.Contains('Name') | Should -Be $true
                    }
    
                }
            }
        }
    }
}