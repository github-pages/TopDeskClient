Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-AssetTemplate" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-AssetTemplate'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection State" {
            
            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-AssetTemplate } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Function Call" {

            $script:TDConnected = $true
            Mock -CommandName Get-APIResponse -MockWith {return 'CardTypes'} -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/cardTypes/' } -Verifiable
            $AsssetTemplate = Get-AssetTemplate

            It "Should call API to get cardTypes" {
                $AsssetTemplate | Should -Be 'cardTypes'
                Assert-VerifiableMock
            }
        }
    }
}