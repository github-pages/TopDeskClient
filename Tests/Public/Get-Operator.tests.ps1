Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Operator" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Operator'
        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {
            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Operator } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }
        }

        Context "Calling no Parameters" {
            $script:TDConnected = $true
            $uri = '/tas/api/operators/lookup'

            Mock -CommandName Get-APIResponse -MockWith { return $null } -ParameterFilter { ($_uri -ilike "*$($uri)*") } -Verifiable
            It "Should perform an API call" {
                Get-Operator
                Assert-VerifiableMock
            }
        }
    }
}
