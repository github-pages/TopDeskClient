Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Disconnect-TopDesk" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Disconnect-TopDesk'

        Context "Disconnecting from tenant" {

            $result = Disconnect-TopDesk

            It "Returns boolean value" {
                $result | Should -BeOfType boolean
            }

            It "Disconnects from tenant" {
                $result | Should -Be $true
            }
        }

        Context "Tenant variables after disconnecting" {

            It "Should clear tentant credentials" {
                $script:tdCredential | Should -BeExactly ([pscredential]::Empty)
            }

            It "Should clear API Version" {
                $script:tdAPIVersion | Should -BeExactly 0
            }

            It "Should clear tdConnected" {
                $script:tdConnected | Should -BeExactly $false
            }

            It "Should clear tenant URL" {
                $script:tdURI | Should -BeNullOrEmpty
            }

        }

    }
}
