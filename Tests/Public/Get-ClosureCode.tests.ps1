Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Get-ClosureCode {

    InModuleScope -ModuleName TopDeskClient {

        Mock -CommandName Get-APIResponse -MockWith { retun 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-ClosureCode } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Call without parameters" {

            $script:TDConnected = $true

            Mock -CommandName Get-APIResponse -MockWith { return $null } -Verifiable

            $result = Get-ClosureCode

            It "Should perform an API call" {
                Assert-VerifiableMock
                $result | Should -Be $null
            }

        }

    }
    
}
