Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Get-BudgetHolder {
    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-BudgetHolder'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { New-Incident -callerLookupEmail 'test@test.testing' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Pipeline input" {
            #N/A
        }

        Context "Call without parameters" {

            $script:TDConnected = $true

            Mock -CommandName Get-APIResponse -MockWith { return $null } -Verifiable

            $result = Get-BudgetHolder

            It "Should perform an API call" {
                Assert-VerifiableMock
                $result | Should -Be $null
            }

        }

        Context "Parameters" {

            Context "external_link_id" {

                $param = (Get-Command $FunctionName).Parameters['external_link_id']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByLink'
                    $param.ParameterSets.ByLink.IsMandatory | Should -Be $true
                    $param.ParameterSets.ByLink.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "external_link_type" {

                $param = (Get-Command $FunctionName).Parameters['external_link_type']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByLink'
                    $param.ParameterSets.ByLink.IsMandatory | Should -Be $true
                    $param.ParameterSets.ByLink.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

        }

    }

}