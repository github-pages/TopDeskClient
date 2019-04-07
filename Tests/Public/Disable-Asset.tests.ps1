Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Disable-Asset {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Disable-Asset'

        Context "Connection state" {

            It "Should throw when client is disconnected" {

                $script:TDConnected = $false
    
                {Disable-Asset -AssetID '12341234-1234-1234-1234-1234567890AB' -Archive -ReasonID '12341234-1234-1234-1234-1234567890AB' } | Should -Throw
                
            }

        }

        Context "Archive or Impact" {

            It "Should archive asset on Archive switch" {
                $script:TDConnected = $true
                [PSCustomObject] $returnobj = @{
                    Settings = @{}
                    metadata = @{
                        templateName = 'test'
                        archived = $true
                        template = @{
                            tabs = @(
                                @{
                                    resourceKey = '12345'
                                    columns = @(
                                        @{
                                            size = '1-2'
                                            widgets = @(
                                                @{
                                                    title = 'testtitle'
                                                    resourceKey = 'testkey'
                                                }
                                            )
                                        }
                                    )
                                }
                            )
                            required = @(
                                'testrequired'
                            )
                        }
                        icon = @{
                            id = '12341234-1234-1234-1234-1234567890AB'
                            name = 'testicon'
                            url16 = 'url16'
                            url32 = 'url32'
                        }
                        autoNumbering = @{
                            enabled = $true
                            prefix = 'testprefix'
                            minLength = 0
                            startIndex = 0
                        }
                        settings = @{
                            visibleOnSSP = $false
                        }
                        '@etag' = 'testetag'
                    }
                    data = @{}
                    fields = @{}
                    functionalities = @{
                        name = 'testfunctionality'
                        parameters = @{
                            additionalProp1 = 'testprop1'
                            additionalProp2 = 'testprop2'
                            additionalProp3 = 'testprop3'
                        }
                    }
                }

                Mock -CommandName  Get-APIResponse -MockWith {return $returnobj }
                $Disabled = Disable-Asset -AssetID '12341234-1234-1234-1234-1234567890AB' -Archive -ReasonID '12341234-1234-1234-1234-1234567890AB' -Force
                $Disabled | Should -Not -BeNullOrEmpty
                $Disabled | Should -BeOfType PSCustomObject

            }

            It "Should update status on Impact switch" {
                $script:TDConnected = $true
                [PSCustomObject] $returnobj = @{
                    Settings = @{}
                    metadata = @{
                        templateName = 'test'
                        archived = $true
                        template = @{
                            tabs = @(
                                @{
                                    resourceKey = '12345'
                                    columns = @(
                                        @{
                                            size = '1-2'
                                            widgets = @(
                                                @{
                                                    title = 'testtitle'
                                                    resourceKey = 'testkey'
                                                }
                                            )
                                        }
                                    )
                                }
                            )
                            required = @(
                                'testrequired'
                            )
                        }
                        icon = @{
                            id = '12341234-1234-1234-1234-1234567890AB'
                            name = 'testicon'
                            url16 = 'url16'
                            url32 = 'url32'
                        }
                        autoNumbering = @{
                            enabled = $true
                            prefix = 'testprefix'
                            minLength = 0
                            startIndex = 0
                        }
                        settings = @{
                            visibleOnSSP = $false
                        }
                        '@etag' = 'testetag'
                    }
                    data = @{}
                    fields = @{}
                    functionalities = @{
                        name = 'testfunctionality'
                        parameters = @{
                            additionalProp1 = 'testprop1'
                            additionalProp2 = 'testprop2'
                            additionalProp3 = 'testprop3'
                        }
                    }
                }

                Mock -CommandName  Get-APIResponse -MockWith {return $returnobj }
                $Disabled = Disable-Asset -AssetID '12341234-1234-1234-1234-1234567890AB' -Impact -Force
                $Disabled | Should -Not -BeNullOrEmpty
                $Disabled | should -BeOfType PSCustomObject

            }

        }

        Context "Parameters" {

            Context "ParameterSets" {
                
                Context "Disable" {

                    It "Should have a parameterset named Disable" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Disable' | Should -Be $true
                    }

                    It "Should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Disable'}).IsDefault | Should -Be $true
                    }

                    It "Should have 4 parameters in Disable" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Disable'}).Parameters.Name | Should -Contain 'AssetID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Disable'}).Parameters.Name | Should -Contain 'Archive'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Disable'}).Parameters.Name | Should -Contain 'ReasonID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Disable'}).Parameters.Name | Should -Contain 'Force'
                    }

                }

                Context "Impact" {

                    It "Should have a parameterset name Impact" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Impact' | Should -Be $true
                    }

                    It "Should have 3 parameters in Impact" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Impact'}).Parameters.Name | Should -Contain 'AssetID'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Impact'}).Parameters.Name | Should -Contain 'Impact'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Impact'}).Parameters.Name | Should -Contain 'Force'
                    }

                }

            }

            Context "Mandatory parameters" {

                It "AssetID should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['AssetID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "Archive should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['Archive'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "ReasonID should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['ReasonID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "Impact should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['Impact'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

                It "Force should NOT be mandatory" {
                    ((Get-Command $FunctionName).Parameters['Force'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($false)
                }

            }

            Context "Parameter Validation" {
            
                Context "AssetID" {
    
                    It "Should be in all Parameter sets" {
                        (Get-Command $FunctionName).Parameters['AssetID'].ParameterSets.ContainsKey('__AllParameterSets') | Should -Be $true
                    }
    
                    It "Should have an alias id" {
                        (Get-Command $FunctionName).Parameters['AssetID'].Aliases.Contains('id') | Should -Be $true
                    }

                    It "Should have an alias unid" {
                        (Get-Command $FunctionName).Parameters['AssetID'].Aliases.Contains('unid') | Should -Be $true
                    }
    
                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['AssetID'].ParameterType.Name | Should -Be String
                    }
    
                }
    
                Context "Archive" {
    
                    It "Should accept a switch" {
                        (Get-Command $FunctionName).Parameters['Archive'].SwitchParameter | Should -Be $true
                    }

                    It "Should be in the Disable parameterset" {
                        (Get-Command $FunctionName).Parameters['Archive'].ParameterSets.ContainsKey('Disable') | Should -Be $true
                    }

                    It "Should only be in one parameterset" {
                        (Get-Command Disable-Asset).Parameters['Archive'].ParameterSets.Count
                    }
    
                }
    
                Context "ReasonID" {
    
                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['ReasonID'].ParameterType.Name | Should -Be String
                    }

                    It "Should be in the Disable parameterset" {
                        (Get-Command $FunctionName).Parameters['ReasonID'].ParameterSets.ContainsKey('Disable') | Should -Be $true
                    }

                    It "Should only be in one parameterset" {
                        (Get-Command Disable-Asset).Parameters['ReasonID'].ParameterSets.Count
                    }
    
                }
    
                Context "Impact" {
    
                    It "Should accept a switch" {
                        (Get-Command $FunctionName).Parameters['Impact'].SwitchParameter | Should -Be $true
                    }

                    It "Should be in the Impact parameterset" {
                        (Get-Command $FunctionName).Parameters['Impact'].ParameterSets.ContainsKey('Impact') | Should -Be $true
                    }

                    It "Should only be in one parameterset" {
                        (Get-Command Disable-Asset).Parameters['Impact'].ParameterSets.Count
                    }
    
                }
    
                Context "Force" {
    
                    It "Should accept a switch" {
                        (Get-Command $FunctionName).Parameters['Force'].SwitchParameter | Should -Be $true
                    }

                    It "Should be in all Parameter sets" {
                        (Get-Command $FunctionName).Parameters['Force'].ParameterSets.ContainsKey('__AllParameterSets') | Should -Be $true
                    }
    
                }
            }
        }

    }
}
