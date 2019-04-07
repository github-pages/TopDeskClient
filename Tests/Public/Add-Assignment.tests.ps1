Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Add-Assignment" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Add-Assignment'
        Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }

        Context "Connection state" {

            It "Should throw when client is disconnected" {

                $script:TDConnected = $false
    
                {Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'branch'} | Should -Throw
                
            }
            
        }

        Context "Pipeline input" {

            It "Accepts pipeline input (AssetID TargetID TargetType)" {

                $script:TDConnected = $true
    
                $Assignthis = [PSCustomObject]@{
                    AssetID = '12341234-1234-1234-1234-1234567890AB'
                    TargetID = '12341234-1234-1234-1234-1234567890AB'
                    TargetType = 'branch'
                }
    
                $Assignment = ($Assignthis | Add-Assignment)
                $Assignment | Should -Not -BeNullOrEmpty
    
            }
            
            It "Accepts pipeline input (AssetID LocationID BranchID)" {

                #Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
                $script:TDConnected = $true
    
                $Assignthis = [PSCustomObject]@{
                    AssetID = '12341234-1234-1234-1234-1234567890AB'
                    LocationID = '12341234-1234-1234-1234-1234567890AB'
                    BranchID = '12341234-1234-1234-1234-1234567890AB'
                }
    
                $Assignment = ($Assignthis | Add-Assignment)
                $Assignment | Should -Not -BeNullOrEmpty
    
            }

        }

        Context "Target types" {

            It "Accepts TargetType of branch" {

                $script:TDConnected = $true
    
                $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'branch'
                $Assignment | Should -Not -BeNullOrEmpty
    
            }
    
            It "Accepts TargetType of person" {
    
                $script:TDConnected = $true
    
                $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'person'
                $Assignment | Should -Not -BeNullOrEmpty
    
            }
    
            It "Accepts TargetType of persongroup" {
    
                $script:TDConnected = $true
    
                $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'persongroup'
                $Assignment | Should -Not -BeNullOrEmpty
    
            }
    
            It "Accepts TargetType of incident" {
    
                $script:TDConnected = $true
    
                $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'incident'
                $Assignment | Should -Not -BeNullOrEmpty
    
            }
            
        }

        Context "Multiple assignments" {

            It "Accepts multiple assignemnts" {

                $script:TDConnected = $true
    
                $Assignthis = [PSCustomObject]@{
                    AssetID = '12341234-1234-1234-1234-1234567890AB'
                    LocationID = '12341234-1234-1234-1234-1234567890AB'
                    BranchID = '12341234-1234-1234-1234-1234567890AB'
                }
                
                $Assignthis1 = [PSCustomObject]@{
                    AssetID = '12341234-1234-1234-1234-1234567890AB'
                    LocationID = '12341234-1234-1234-1234-1234567890AB'
                    BranchID = '12341234-1234-1234-1234-1234567890AB'
                }
    
                $Assignthis2 = [PSCustomObject]@{
                    AssetID = '12341234-1234-1234-1234-1234567890AB'
                    LocationID = '12341234-1234-1234-1234-1234567890AB'
                    BranchID = '12341234-1234-1234-1234-1234567890AB'
                }
    
                $AssignJobs = @($Assignthis,$Assignthis1,$Assignthis2)
    
                $Assignment = ($AssignJobs | Add-Assignment)
                $Assignment | Should -Not -BeNullOrEmpty
    
                Assert-MockCalled Get-APIResponse -Times 3 -Exactly
    
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

                    It "Should have 3 parameters in Default" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'AssetID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'TargetID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'TargetType'
                    }

                }

                Context "location" {

                    It "Should have a parameterset name location" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'location' | Should -Be $true
                    }

                    It "Should have 3 parameters in location" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'location'}).Parameters.Name | Should -Contain 'AssetID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'location'}).Parameters.Name | Should -Contain 'LocationID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'location'}).Parameters.Name | Should -Contain 'BranchID'
                    }

                }

            }

            Context "Mandatory parameters" {

                It "AssetID should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['AssetID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    #(Get-Command $FunctionName).Parameters['AssetID'].ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                }

                It "TargetID should be mandatory" {
                    #(Get-Command $FunctionName).Parameters['TargetID'].ParameterSets['Default'].IsMandatory | Should -Be $true
                    ((Get-Command $FunctionName).Parameters['TargetID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "TargetType should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['TargetType'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "LocationID should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['LocationID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "BranchID should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['BranchID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

            }

            Context "Parameter Validation" {
            
                Context "AssetID" {
    
                    It "Should be in all Parameter sets" {
                        (Get-Command $FunctionName).Parameters['AssetID'].ParameterSets.ContainsKey('__AllParameterSets') | Should -Be $true
                    }
    
                    It "Should have an alias unid" {
                        (Get-Command $FunctionName).Parameters['AssetID'].Aliases.Contains('unid') | Should -Be $true
                    }
    
                    It "Should accept on or more strings" {
                        (Get-Command $FunctionName).Parameters['AssetID'].ParameterType.Name | Should -Be String[]
                    }
    
                }
    
                Context "TargetID" {
    
                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['TargetID'].ParameterType.Name | Should -Be String
                    }
    
                    It "Should have an alias id" {
                        (Get-Command $FunctionName).Parameters['TargetID'].Aliases.Contains('id') | Should -Be $true
                    }
    
                }
    
                Context "TargetType" {
    
                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['TargetType'].ParameterType.Name | Should -Be String
                    }
    
                }
    
                Context "LocationID" {
    
                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['LocationID'].ParameterType.Name | Should -Be String
                    }
    
                }
    
                Context "BranchID" {
    
                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['BranchID'].ParameterType.Name | Should -Be String
                    }
    
                }
            }
        }

    }
}