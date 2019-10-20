Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Get-Category {
    InModuleScope -ModuleName TopDeskClient {

        Mock -CommandName Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Category } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Call without parameters" {

            $script:TDConnected = $true

            Mock -CommandName Get-APIResponse -MockWith { return $null } -Verifiable

            $result = Get-Category

            It "Should perform an API call" {
                Assert-VerifiableMock
                $result | Should -Be $null
            }

        }

    }
}
