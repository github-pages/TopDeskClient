Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-APIResponse" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-APIResponse'
        $pass = ConvertTo-SecureString -String 'testpass' -AsPlainText -Force
        $creds = [pscredential]::new('testuser',$pass)
        $headers = @{ 'test' = 'test1'}
        $uri = 'https://testing.my.test'
        Mock -CommandName Invoke-RestMethod -MockWith { return $null }

        Context "Calls" {

            Context "GET" {
                Mock -CommandName Invoke-RestMethod -MockWith { return $null } -ParameterFilter { $Method -and $Method -eq 'GET' } -Verifiable
                Get-APIResponse -Method 'GET' -APIurl $uri -Headers $headers -tdCredential $creds

                It "Should use invoke-restmethod with proper credentials" {
                    Assert-VerifiableMock
                }
            }

            Context "PUT" {
                Mock -CommandName Invoke-RestMethod -MockWith { return $null } -ParameterFilter { $Method -and $Method -eq 'PUT' } -Verifiable
                Get-APIResponse -Method 'PUT' -APIurl $uri -Headers $headers -tdCredential $creds

                It "Should use invoke-restmethod with proper credentials" {
                    Assert-VerifiableMock
                }
            }

            Context "POST" {
                Mock -CommandName Invoke-RestMethod -MockWith { return $null } -ParameterFilter { $Method -and $Method -eq 'POST' } -Verifiable
                Get-APIResponse -Method 'POST' -APIurl $uri -Headers $headers -tdCredential $creds

                It "Should use invoke-restmethod with proper credentials" {
                    Assert-VerifiableMock
                }
            }

            Context "DELETE" {
                Mock -CommandName Invoke-RestMethod -MockWith { return $null } -ParameterFilter { $Method -and $Method -eq 'DELETE' } -Verifiable
                Get-APIResponse -Method 'DELETE' -APIurl $uri -Headers $headers -tdCredential $creds

                It "Should use invoke-restmethod with proper credentials" {
                    Assert-VerifiableMock
                }
            }
        }

        Context "Parameters" {

            Context "Method" {
                $param = (Get-Command $FunctionName).Parameters['Method']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

            Context "APIurl" {
                $param = (Get-Command $FunctionName).Parameters['APIurl']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'url'
                }
            }

            Context "Headers" {
                $param = (Get-Command $FunctionName).Parameters['Headers']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }
            }

            Context "tdCredential" {
                $param = (Get-Command $FunctionName).Parameters['tdCredential']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__Allparametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'pscredential'
                }
            }

            Context "Body" {
                $param = (Get-Command $FunctionName).Parameters['Body']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }

        }
    }
}
