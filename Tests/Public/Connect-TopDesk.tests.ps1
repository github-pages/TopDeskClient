Describe Connect-TopDesk {
    Context 'Valid URL' {
        It "Requires a valid URL" {
            Connect-TopDesk -TopDeskURI 'topdesk.net' -ErrorAction SilentlyContinue | Should -Be $false
        }
    }

    Context 'Empty URL' {
        It "Requires a URL" {
           { Connect-TopDesk } | Should -Throw
        }
    }
}
