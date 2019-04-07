Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Enable-Asset {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Enable-Asset'

        Context "Connection state" {

            It "Should throw when client is disconnected" {

                $script:TDConnected = $false
    
                {Enable-Asset -AssetID '12341234-1234-1234-1234-1234567890AB' } | Should -Throw
                
            }

        }

        Context "Enable Asset" {

            [PSCustomObject] $archiveobj = @{
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
                data = @{
                    archived = $true
                    '@status' = 'OPERATIONAL'
                }
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

            [PSCustomObject] $impactobj = @{
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
                data = @{
                    archived = $false
                    "@status" = 'IMPACTED'
                }
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

            [PSCustomObject] $resultobj = @{
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
                data = @{
                    archived = $false
                    '@status' = 'OPERATIONAL'
                }
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

            It "Should enable an archived asset" {
                $script:TDConnected = $true

                Mock -CommandName Get-APIResponse -MockWith { return $archiveobj } -ParameterFilter {$Method -eq 'GET' } -Verifiable
                Mock -CommandName Get-APIResponse -MockWith { return $resultobj } -ParameterFilter { $Method -eq 'POST' } -Verifiable
                $Enabled = Enable-Asset -AssetID '12341234-1234-1234-1234-1234567890AB'
                $Enabled | Should -Not -BeNullOrEmpty
                $Enabled | Should -BeOfType PSCustomObject
                Assert-VerifiableMock

            }

            It "Should enable an impacted asset" {
                $script:TDConnected = $true

                Mock -CommandName Get-APIResponse -MockWith { return $impactobj } -ParameterFilter {$Method -eq 'GET' } -Verifiable
                Mock -CommandName Get-APIResponse -MockWith { return $resultobj } -ParameterFilter { $Method -eq 'POST' } -Verifiable
                $Enabled = Enable-Asset -AssetID '12341234-1234-1234-1234-1234567890AB'
                $Enabled | Should -Not -BeNullOrEmpty
                $Enabled | Should -BeOfType PSCustomObject
                Assert-VerifiableMock

            }

        }

        Context "Parameters" {

            Context "Parametersets" {

                It "Should have a parameterset name Default" {
                    (Get-Command $FunctionName).ParameterSets.Name -icontains 'Default' | Should -Be $true
                }

                It "Should be the default parameterset" {
                    (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).IsDefault | Should -Be $true
                }

            }

            Context "Mandatory Parameters" {

                It "AssetID should be mandatory" {
                    ((Get-Command $FunctionName).Parameters['AssetID'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                }

            }

            Context "Parameter Validation" {

                Context "AssetID" {

                    It "Should have an alias unid" {
                        (Get-Command $FunctionName).Parameters['AssetID'].Aliases.Contains('unid') | Should -Be $true
                    }

                    It "Should accept a string" {
                        (Get-Command $FunctionName).Parameters['AssetID'].ParameterType.Name | Should -Be String
                    }

                }
            }

        }
        
    }
}