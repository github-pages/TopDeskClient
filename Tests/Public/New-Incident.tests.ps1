Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "New-Incident" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'New-Incident'

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
            $script:TDConnected = $true

        }

        Context "Calling with parameters" {
            
            $script:TDConnected = $true

        }

        Context "Parameters" {

            Context "callerLookupEmail" {

                $param = (Get-Command $FunctionName).Parameters['callerLookupEmail']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'byEmail'
                    $param.ParameterSets.byEmail.IsMandatory | Should -Be $true
                    $param.ParameterSets.byEmail.ValueFromPipelineByPropertyName | Should -Be $false
                    $param.ParameterType.Name | Should -Be 'string'
                }
            }
        }
    }
}