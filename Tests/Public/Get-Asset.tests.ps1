Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Asset" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Asset'
        
        <# $ArchiveReasons = @(
            [PSCustomObject]@{
                name = 'Not current'
                id   = '40fa4bd0-a3e3-4ea5-a4d6-c2458a11f793'
            },
            [PSCustomObject]@{
                name = 'written off'
                id   = '55509351-2bd5-4588-bd3c-5f20780bb0b4'
            }
        ) #>

       <#  [PSCustomObject] $returnobj = @{
            Settings        = @{ }
            metadata        = @{
                templateName  = 'test'
                archived      = $true
                template      = @{
                    tabs     = @(
                        @{
                            resourceKey = '12345'
                            columns     = @(
                                @{
                                    size    = '1-2'
                                    widgets = @(
                                        @{
                                            title       = 'testtitle'
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
                icon          = @{
                    id    = '12341234-1234-1234-1234-1234567890AB'
                    name  = 'testicon'
                    url16 = 'url16'
                    url32 = 'url32'
                }
                autoNumbering = @{
                    enabled    = $true
                    prefix     = 'testprefix'
                    minLength  = 0
                    startIndex = 0
                }
                settings      = @{
                    visibleOnSSP = $false
                }
                '@etag'       = 'testetag'
            }
            data            = @{ }
            fields          = @{ }
            functionalities = @{
                name       = 'testfunctionality'
                parameters = @{
                    additionalProp1 = 'testprop1'
                    additionalProp2 = 'testprop2'
                    additionalProp3 = 'testprop3'
                }
            }
        } #>

        Mock -CommandName  Get-APIResponse -MockWith { return $returnobj }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Asset -AssetType 'Computer' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
            
        }

        Context "Pipeline input" {

            $TypeofAssets = [PSCustomObject]@{
                AssetType = 'Computer'
            }

            $typeofAssetsActive = [PSCustomObject]@{
                AssetType = 'Computer'
                OperationalStatus = 'Operational'
            }

            $typeofAssetsFields = [PSCustomObject]@{
                AssetType = 'Computer'
                AssetFields = @('name','archived')
            }

            $typeofAssetsNameSearch = [PSCustomObject]@{
                Name = '1234567'
            }

            $typeofAssetsFreeSearch = [PSCustomObject]@{
                SearchString = '1234567'
            }

            $script:TDConnected = $true

            $returnobj = [PSCustomObject]@{
                columns = @(
                    @{
                        resourceKey = 'mykey'
                        properties = @{}
                        fieldName = 'myfield'
                        displayName = 'myasset'
                    }
                )
                dataset = @(
                    @{
                        name     = '1234567'
                        unid     = '12341234-1234-1234-1234-1234567890AB'
                        archived = $false
                        '@status' = 'OPERATIONAL'
                    },
                    @{
                        name     = '8901234'
                        unid     = '12341234-1234-1234-1234-1234567890CD'
                        archived = $false
                        '@status' = 'OPERATIONAL'
                    },
                    @{
                        name     = '5678901'
                        unid     = '12341234-1234-1234-1234-1234567890EF'
                        archived = $true
                        '@status' = 'IMPACTED'
                    }
                )
                functionalities = @()
                settings = @{}
                resources = @{}
                templates = @()
                rawentry = @{}
            }

            $returnobja = [PSCustomObject]@{
                columns = @(
                    @{
                        resourceKey = 'mykey'
                        properties = @{}
                        fieldName = 'myfield'
                        displayName = 'myasset'
                    }
                )
                dataset = @(
                    @{
                        name     = '1234567'
                        unid     = '12341234-1234-1234-1234-1234567890AB'
                        archived = $false
                        '@status' = 'OPERATIONAL'
                    },
                    @{
                        name     = '8901234'
                        unid     = '12341234-1234-1234-1234-1234567890CD'
                        archived = $false
                        '@status' = 'OPERATIONAL'
                    }
                )
                functionalities = @()
                settings = @{}
                resources = @{}
                templates = @()
                rawentry = @{}
            }

            $returnobjn = [PSCustomObject]@{
                columns = @(
                    @{
                        resourceKey = 'mykey'
                        properties = @{}
                        fieldName = 'myfield'
                        displayName = 'myasset'
                    }
                )
                dataset = @(
                    @{
                        name     = '1234567'
                        unid     = '12341234-1234-1234-1234-1234567890AB'
                        archived = $false
                        '@status' = 'OPERATIONAL'
                    }
                )
                functionalities = @()
                settings = @{}
                resources = @{}
                templates = @()
                rawentry = @{}
            }

            Mock -CommandName Get-APIResponse -MockWith { return $null }
            Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=Computer&fields=name&showAssignments=$true' } -Verifiable
            Mock -CommandName Get-APIResponse -MockWith { return $returnobja } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=Computer&fields=name&showAssignments=$true&assetStatus=Operational' } -Verifiable
            Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=Computer&fields=name,archived&showAssignments=$true' } -Verifiable
            Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?nameFragment=1234567&fields=name&showAssignments=$true' } -Verifiable
            Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?searchTerm=1234567&fields=name&showAssignments=$true' } -Verifiable

            Context "All Assets by Type" {
                
                $Assets = ($TypeofAssets | Get-Asset)

                It "Returns a value when piped an AssetType" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of type computer" {
                    $Assets | Should -HaveCount 3
                }

                It "Performs 1 API call" {
                    Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                }

            }

            Context "All Operational Assets by Type" {

                $Assets = ($TypeofAssetsActive | Get-Asset)

                It "Returns a value when piped an AssetType with status" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all active assets of type computer" {
                    $Assets | Should -HaveCount 2
                }

                It "Performs 1 API call" {
                    Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                }

            }

            Context "Assets with selected fields" {
                $Assets = ($typeofAssetsFields | Get-Asset)

                It "Returns a value when piped an AssetType with selected fields" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of type computer" {
                    $Assets | Should -HaveCount 3
                }

                It "Performs 1 API call" {
                    Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                }
            }

            Context "Assets by name search" {
                $Assets = ($typeofAssetsNameSearch | Get-Asset)

                It "Returns a value when piped an asset name to search" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets | Should -HaveCount 1
                }

                It "Performs 1 API call" {
                    Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                }
            }

            Context "Assets by search string" {
                $Assets = ($typeofAssetsFreeSearch | Get-Asset)

                It "Returns a value when piped an asset name to search" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets | Should -HaveCount 1
                }

                It "Performs 1 API call" {
                    Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                }
            }

            Context "Assets by LinkList" {

            }

            Context "Assets by Filter" {

            }

            It "Uses verfied Mocks" {
                Assert-VerifiableMock
            }
        }

        <# Context "Calling with params" {

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
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).IsDefault | Should -Be $true
                    }

                    It "Should have 1 parameter in Default" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Default' }).Parameters.Name | Should -Contain 'All'
                    }

                }

                Context "ByName" {

                    It "Should have a parameterset name ByName" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'ByName' | Should -Be $true
                    }

                    It "Should have 1 parameter in ByName" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'ByName' }).Parameters.Name | Should -Contain 'ReasonName'
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
        } #>
    }
}