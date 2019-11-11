Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "New-BasicIncident" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'New-BasicIncident'
        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { New-BasicIncident -CallerType 'email' -Caller 'test@test.testing' -BriefDescription 'Test' -Request 'Testing' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
        }

        Context "Pipeline Input" {

            $script:TDConnected = $true
            $baseURI = '/tas/api/incidents/'

            Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter {$_uri -eq $baseURI -and ($_body -like '*"callerLookup":{"email":"test@test.com"}*') -and ($_body -ilike '*"briefDescription":"Test"*') -and ($_body -ilike '*"request":"Testing"*')} -Verifiable

            It "Should perform an API call" {
                [PSCustomObject]@{
                    CallerType       = 'email'
                    Caller           = 'test@test.com'
                    BriefDescription = 'Test'
                    Request          = 'Testing'
                } | New-BasicIncident | Should -Be $null
                Assert-VerifiableMock
            }
        }

        Context "Calling with parameters" {
            $script:TDConnected = $true
            $param1 = 'A1234567-4444-4444-4444-121212121212'
            $param2 = 'secondLine'
            $param3 = 'test@test.com'
            $param4 = 'Test'
            $param5 = 'Testing'
            $param6 = '171717'
            $param7 = 'tester'
            $param8 = 'tester2'
            $baseURI = 'tas/api/incidents/'

            $jsonp1 = '"callerLookup":{"id":"'+$param1+'"}'
            $jsonp2 = '"status":"'+$param2+'"'
            $jsonp3 = '"callerLookup":{"email":"'+$param3+'"'
            $jsonp4 = '"briefDescription":"'+$param4+'"'
            $jsonp5 = '"request":"'+$param5+'"'
            $jsonp6 = '"callerLookup":{"employeenumber":"'+$param6+'"'
            $jsonp7 = '"callerLookup":{"networkLoginName":"'+$param7+'"'
            $jsonp8 = '"callerLookup":{"loginName":"'+$param8+'"'


            Context "Caller by ID" {

                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -ilike "*$($baseURI)*") -and ($_body -ilike "*$($jsonp1)*") -and ($_body -ilike "*$($jsonp4)*") -and ($_body -ilike "*$($jsonp5)*") -and ($_body -ilike "*$($jsonp2)*") } -Verifiable
                It "Should perform an API call" {
                    New-BasicIncident -CallerType 'id' -Caller $param1 -Status $param2 -BriefDescription $param4 -Request $param5
                    Assert-VerifiableMock
                }
            }

            Context "Caller by Email" {

                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -ilike "*$($baseURI)*") -and ($_body -ilike "*$($jsonp3)*") -and ($_body -ilike "*$($jsonp4)*") -and ($_body -ilike "*$($jsonp5)*") -and ($_body -ilike "*$($jsonp2)*") } -Verifiable
                It "Should perform an API call" {
                    New-BasicIncident -CallerType 'email' -Caller $param3 -Status $param2 -BriefDescription $param4 -Request $param5
                    Assert-VerifiableMock
                }
            }

            Context "Caller by Employee Number" {

                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -ilike "*$($baseURI)*") -and ($_body -ilike "*$($jsonp6)*") -and ($_body -ilike "*$($jsonp4)*") -and ($_body -ilike "*$($jsonp5)*") -and ($_body -ilike "*$($jsonp2)*") } -Verifiable
                It "Should perform an API call" {
                    New-BasicIncident -CallerType 'employeenumber' -Caller $param6 -Status $param2 -BriefDescription $param4 -Request $param5
                    Assert-VerifiableMock
                }
            }

            Context "Caller by Network Login Name" {

                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -ilike "*$($baseURI)*") -and ($_body -ilike "*$($jsonp7)*") -and ($_body -ilike "*$($jsonp4)*") -and ($_body -ilike "*$($jsonp5)*") -and ($_body -ilike "*$($jsonp2)*") } -Verifiable
                It "Should perform an API call" {
                    New-BasicIncident -CallerType 'networkLoginName' -Caller $param7 -Status $param2 -BriefDescription $param4 -Request $param5
                    Assert-VerifiableMock
                }
            }

            Context "Caller by Login Name" {

                Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -ilike "*$($baseURI)*") -and ($_body -ilike "*$($jsonp8)*") -and ($_body -ilike "*$($jsonp4)*") -and ($_body -ilike "*$($jsonp5)*") -and ($_body -ilike "*$($jsonp2)*") } -Verifiable
                It "Should perform an API call" {
                    New-BasicIncident -CallerType 'loginName' -Caller $param8 -Status $param2 -BriefDescription $param4 -Request $param5
                    Assert-VerifiableMock
                }
            }

            Context "CallerType" {

                $param = (Get-Command $FunctionName).Parameters['CallerType']

                It "Should maintain compatibility" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'

                }
            }

            Context "Caller" {
                $param = (Get-Command $FunctionName).Parameters['Caller']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "Status" {
                $param = (Get-Command $FunctionName).Parameters['Status']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "BriefDescription" {
                $param = (Get-Command $FunctionName).Parameters['BriefDescription']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "Request" {
                $param = (Get-Command $FunctionName).Parameters['Request']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "EntryType" {
                $param = (Get-Command $FunctionName).Parameters['EntryType']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "CallType" {
                $param = (Get-Command $FunctionName).Parameters['CallType']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "Category" {
                $param = (Get-Command $FunctionName).Parameters['Category']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "SubCategory" {
                $param = (Get-Command $FunctionName).Parameters['SubCategory']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "ObjectName" {
                $param = (Get-Command $FunctionName).Parameters['ObjectName']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "Impact" {
                $param = (Get-Command $FunctionName).Parameters['Impact']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "Urgency" {
                $param = (Get-Command $FunctionName).Parameters['Urgency']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "TargetDate" {
                $param = (Get-Command $FunctionName).Parameters['TargetDate']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "Operator" {
                $param = (Get-Command $FunctionName).Parameters['Operator']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "OperatorGroup" {
                $param = (Get-Command $FunctionName).Parameters['OperatorGroup']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "MajorCallNumber" {
                $param = (Get-Command $FunctionName).Parameters['MajorCallNumber']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true

                    $param.ParameterType.Name | Should -Be 'string'
                }
            }
        }
    }
}