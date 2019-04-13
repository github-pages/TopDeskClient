Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Get-AssetTemplateList {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-AssetTemplateList'

        Mock -CommandName Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-AssetTemplateList } | Should -Throw
            }
        }

        Context "Get AssetTemplateList" {

            $script:TDConnected = $true
            Mock -CommandName Get-APIResponse -MockWith { return 'AssetTemplateList' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/assetmgmt/templates' } -Verifiable
            $AssetTemplateLIst = Get-AssetTemplateList

            It "Calls API to get AssetTemplateList" {

                $AssetTemplateLIst | Should -Not -BeNullOrEmpty
                $AssetTemplateLIst | Should -Be 'AssetTemplateList'
                Assert-VerifiableMock

            }
        }
    }
}
