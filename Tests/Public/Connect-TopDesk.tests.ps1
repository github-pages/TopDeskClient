Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Connect-TopDesk {
    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Connect-TopDesk'
        Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{version = "1.0.0"})}
        Mock -CommandName Get-tdCredentail -MockWith {return ([pscredential]::new('test',(ConvertTo-SecureString -String 'test' -AsPlainText -Force)))}

        Context "Connectiing to tenant" {
            
            It "Returns $false for invalid URLs" {

                Connect-TopDesk -uri 'badurltest' -ErrorAction SilentlyContinue | Should -Be $false
    
            }
    
            It "Connects when provided valid URL" {
    
                Connect-TopDesk -uri 'https://scdsb.topdesk.net' | Should -Be $true
                Assert-MockCalled -CommandName Get-tdCredentail -Times 1 -Exactly
                Assert-MockCalled -CommandName Get-APIResponse -Times 1 -Exactly
                
            }
            
        }

        Context "Required Parameters" {

            It "TopdeskURI (x3)" {

                # Required for 3 parameter sets
                ((Get-Command $FunctionName).Parameters['TopDeskURI'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should Be @($true, $true, $true)

            }

            It "Save (x1)" {

                # Required for 1 parameter set
                ((Get-Command $FunctionName).Parameters['Save'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should Be $true

            }

            It "Load (x1)" {

                # Required for 1 parameter set
                ((Get-Command $FunctionName).Parameters['Load'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should Be $true

            }
            
        } 
    }
}
