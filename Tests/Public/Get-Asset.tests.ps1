Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Asset" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Asset'

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

            $LinkListSearch = [PSCustomObject]@{
                LinkList = [Hashtable]@{
                    'person' = '1234567'
                }
            }

            $MyFilter = [PSCustomObject]@{
                Filter = 'name eq 1234567'
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

            $returnobj06 = [PSCustomObject]@{
                Name = 'LinkedAsset'
            }

            $returnobjFiltered = [PSCustomObject]@{
                Name = 'Filtered Asset'
            }

            Mock -CommandName Get-APIResponse -MockWith { return 'catch-all' }
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=Computer&fields=name&showAssignments=$true' } -Verifiable
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobja } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=Computer&fields=name&showAssignments=$true&assetStatus=Operational' } -Verifiable
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=Computer&fields=name,archived&showAssignments=$true' } -Verifiable
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?nameFragment=1234567&fields=name&showAssignments=$true' } -Verifiable
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?searchTerm=1234567&fields=name&showAssignments=$true' } -Verifiable
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobj06 } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?linkedTo=person/1234567&fields=name&showAssignments=$true' } -Verifiable
            #Mock -CommandName Get-APIResponse -MockWith { return $returnobjFiltered } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=name eq 1234567&fields=name&showAssignments=$true' } -Verifiable

            Context "All Assets by Type" {
                
                $param1 = $TypeofAssets.AssetType
                Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = ($TypeofAssets | Get-Asset)

                It "Returns a value when piped an AssetType" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of type computer" {
                    $Assets | Should -HaveCount 3
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                }

            }

            Context "All Operational Assets by Type" {

                $param1 = $TypeofAssetsActive.AssetType
                $param2 = $TypeofAssetsActive.OperationalStatus
                Mock -CommandName Get-APIResponse -MockWith { return $returnobja } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=' + $param1 + '&fields=name&showAssignments=$true&assetStatus=' + $param2 } -Verifiable
                $Assets = ($TypeofAssetsActive | Get-Asset)

                It "Returns a value when piped an AssetType with status" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all active assets of type computer" {
                    $Assets | Should -HaveCount 2
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                }

            }

            Context "Assets with selected fields" {
                $param1 = $typeofAssetsFields.AssetType
                $param2 = ($typeofAssetsFields.AssetFields -join ',')
                Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=' + $param1 + '&fields=' + $param2 + '&showAssignments=$true' } -Verifiable
                $Assets = ($typeofAssetsFields | Get-Asset)

                It "Returns a value when piped an AssetType with selected fields" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of type computer" {
                    $Assets | Should -HaveCount 3
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                }
            }

            Context "Assets by name search" {
                $param1 = $typeofAssetsNameSearch.Name
                Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?nameFragment=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = ($typeofAssetsNameSearch | Get-Asset)

                It "Returns a value when piped an asset name to search" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets | Should -HaveCount 1
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                }
            }

            Context "Assets by search string" {
                $param1 = $typeofAssetsFreeSearch.SearchString
                Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?searchTerm=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = ($typeofAssetsFreeSearch | Get-Asset)

                It "Returns a value when piped an asset name to search" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets | Should -HaveCount 1
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                }
            }

            Context "Assets by LinkList" {
                $param1 = ''
                $LinkListSearch.LinkList | ForEach-Object { $param1 += $_.Keys.Trim() + '/' + $_.Values.Trim() }
                Mock -CommandName Get-APIResponse -MockWith { return $returnobj06 } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?linkedTo=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = ($LinkListSearch | Get-Asset)

                It "Returns a value when piped a hashtable of link type and id" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets.Name | Should -Be 'LinkedAsset'
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                }
            }

            Context "Assets by Filter" {
                $param1 = $MyFilter.Filter
                Mock -CommandName Get-APIResponse -MockWith { return $returnobjFiltered } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = ($MyFilter | Get-Asset)

                It "Returns a value when piped a filter string" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns matching asset" {
                    $Assets.name | Should -Be 'Filtered Asset'
                }

                It "Performs 1 API call" {
                    #Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                    Assert-VerifiableMock
                } 
            }

            Context "Summary" {
                It "Uses verfied Mocks" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            Mock -CommandName Get-APIResponse -MockWith { return 'catch-all' }

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

            $returnobj06 = [PSCustomObject]@{
                Name = 'LinkedAsset'
            }

            $returnobjFiltered = [PSCustomObject]@{
                Name = 'Filtered Asset'
            }

            $LinkListSearch = [PSCustomObject]@{
                LinkList = [Hashtable]@{
                    'person' = '1234567'
                }
            }

            Context "Get Assets by Type" {
                $param1 = 'Computer'
                Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = (Get-Asset -AssetType $param1)

                It "Should return a value" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of type computer" {
                    $Assets | Should -HaveCount 3
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }

            }

            Context "All Operational Assets by Type" {
                $param1 = 'Computer'
                $param2 = 'OPERATIONAL'
                Mock -CommandName Get-APIResponse -MockWith { return $returnobja } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=' + $param1 + '&fields=name&showAssignments=$true&assetStatus=' + $param2 } -Verifiable
                $Assets = (Get-Asset -AssetType $param1 -OperationalStatus $param2)

                It "Should return a value" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of specified type and operational" {
                    $Assets | Should -HaveCount 2
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Assets with selected fields" {
                $param1 = 'Computer'
                $param2 = (@('name','archived') -join ',')
                Mock -CommandName Get-APIResponse -MockWith { return $returnobj } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?templateName=' + $param1 + '&fields=' + $param2 + '&showAssignments=$true' } -Verifiable
                $Assets = (Get-Asset -AssetType $param1 -AssetFields $param2)

                It "Should return a value" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns all assets of specified type and operational" {
                    $Assets | Should -HaveCount 3
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Assets by name search" {
                $param1 = '1234567'
                Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?nameFragment=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = Get-Asset -Name $param1

                It "Returns a value when piped an asset name to search" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets | Should -HaveCount 1
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Assets by search string" {
                $param1 = '1234567'
                Mock -CommandName Get-APIResponse -MockWith { return $returnobjn } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?searchTerm=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = (Get-Asset -SearchString $Param1)

                It "Returns a value when piped an asset name to search" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets | Should -HaveCount 1
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Assets by LinkList" {
                $param1 = @{
                    person = '1234567'
                }
                $param1url = ''
                $LinkListSearch.LinkList | ForEach-Object { $param1url += $_.Keys.Trim() + '/' + $_.Values.Trim() }
                Mock -CommandName Get-APIResponse -MockWith { return $returnobj06 } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?linkedTo=' + $param1url + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = (Get-Asset -LinkList $param1)

                It "Returns a value when piped a hashtable of link type and id" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns one matching asset" {
                    $Assets.Name | Should -Be 'LinkedAsset'
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Assets by Filter" {
                $param1 = 'name eq 1234567'
                Mock -CommandName Get-APIResponse -MockWith { return $returnobjFiltered } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/assets?$filter=' + $param1 + '&fields=name&showAssignments=$true' } -Verifiable
                $Assets = Get-Asset -Filter $param1

                It "Returns a value when piped a filter string" {
                    $Assets | Should -Not -BeNullOrEmpty
                }

                It "Returns matching asset" {
                    $Assets.name | Should -Be 'Filtered Asset'
                }

                It "Performs 1 API call" {
                    Assert-VerifiableMock
                } 
            }

        }

        Context "Parameters" {

            Context "ParameterSets" {

                Context "Default" {

                    It "Should have a parameterset named AllAssets" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'AllAssets' | Should -Be $true
                    }

                    It "AllAssets should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'AllAssets' }).IsDefault | Should -Be $true
                    }

                    It "Should have 5 parameters in AllAssets" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'AllAssets' }).Parameters.Name | Should -Contain 'AssetType'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'AllAssets' }).Parameters.Name | Should -Contain 'OperationalStatus'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'AllAssets' }).Parameters.Name | Should -Contain 'ActiveOnly'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'AllAssets' }).Parameters.Name | Should -Contain 'AssetFields'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'AllAssets' }).Parameters.Name | Should -Contain 'NoAssignments'
                    }

                }

                Context "ArchivedAssets" {

                    It "Should have a parameterset name ArchivedAssets" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'ArchivedAssets' | Should -Be $true
                    }

                    It "Should have 3 parameter in ArchivedAssets" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'ArchivedAssets' }).Parameters.Name | Should -Contain 'AssetType'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'ArchivedAssets' }).Parameters.Name | Should -Contain 'OperationalStatus'
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'ArchivedAssets' }).Parameters.Name | Should -Contain 'ArchivedOnly'
                    }

                }

                Context "NameSearch" {

                    It "Should have a parameterset name NameSearch" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'NameSearch' | Should -Be $true
                    }

                    It "Should have 1 parameter in NameSearch" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'NameSearch' }).Parameters.Name | Should -Contain 'Name'
                    }

                }

                Context "FreeText" {
                    
                    It "Should have a parameterset name FreeText" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'FreeText' | Should -Be $true
                    }

                    It "Should have 1 parameter in FreeText" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'FreeText' }).Parameters.Name | Should -Contain 'SearchString'
                    }

                }

                Context "LinkSearch" {

                    It "Should have a parameterset name LinkSearch" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'LinkSearch' | Should -Be $true
                    }

                    It "Should have 1 parameter in LinkSearch" {
                        (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'LinkSearch' }).Parameters.Name | Should -Contain 'LinkList'
                    }

                    Context "Filter" {

                        It "Should have a parameterset name Filter" {
                            (Get-Command $FunctionName).ParameterSets.Name -icontains 'Filter' | Should -Be $true
                        }
    
                        It "Should have 1 parameter in Filter" {
                            (Get-Command $FunctionName).ParameterSets.Where( { $_.Name -eq 'Filter' }).Parameters.Name | Should -Contain 'Filter'
                        }

                    }
                }
            }

            Context "Mandatory parameters" {

                It "AssetType should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName AssetType -Type [string] -Mandatory
                }

                It "OperationalStatus should NOT be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'OperationalStatus'  -Type [string]
                }

                It "ActiveOnly should NOT be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'ActiveOnly' -Type [switch]
                }

                It "ArchivedOnly should NOT be madatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'ArchivedOnly' -Type [switch]
                }

                It "AssetFields should NOT be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'ASsetFields' -Type [string[]]
                }

                It "NoAssignments should NOT be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'NoAssignments' -Type [switch]
                }

                It "Name should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'Name' -Type [string] -Mandatory
                }

                It "SearchString should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'SearchString' -Type [string] -Mandatory
                }

                It "LinkList should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'LinkList' -Type [hashtable] -Mandatory
                }

                It "Filter should be mandatory" {
                    Get-Command $FunctionName | Should -HaveParameter -ParameterName 'Filter' -Type [string] -Mandatory
                }
            }

            Context "Parameter Validation" {

                Context "OperationalStatus" {

                    It "Should have an alias Status" {
                        (Get-Command $FunctionName).Parameters['OperationalStatus'].Aliases.Contains('Status') | Should -Be $true
                    }

                }

                Context "LinkList" {

                    It "Should have an alias Links" {
                        (Get-Command $FunctionName).Parameters['LinkList'].Aliases.Contains('Links') | Should -Be $true
                    }
                    
                }
            }
        }
    }
}