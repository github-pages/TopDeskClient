Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1

Describe "Add-Assignment" {

    InModuleScope -ModuleName TopDeskClient {

        It "Accepts multiple assignemnts" {
            Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
            $script:TDConnected = $true

            $Assignthis = [PSCustomObject]@{
                AssetID = '12341234-1234-1234-1234-1234567890AB'
                LocationID = '12341234-1234-1234-1234-1234567890AB'
                BranchID = '12341234-1234-1234-1234-1234567890AB'
            }
            
            $Assignthis1 = [PSCustomObject]@{
                AssetID = '12341234-1234-1234-1234-1234567890AB'
                LocationID = '12341234-1234-1234-1234-1234567890AB'
                BranchID = '12341234-1234-1234-1234-1234567890AB'
            }

            $Assignthis2 = [PSCustomObject]@{
                AssetID = '12341234-1234-1234-1234-1234567890AB'
                LocationID = '12341234-1234-1234-1234-1234567890AB'
                BranchID = '12341234-1234-1234-1234-1234567890AB'
            }

            $AssignJobs = @($Assignthis,$Assignthis1,$Assignthis2)

            $Assignment = ($AssignJobs | Add-Assignment)
            $Assignment | Should -Not -BeNullOrEmpty

            Assert-MockCalled Get-APIResponse -Times 3 -Exactly

        }

        It "Accepts pipeline input (AssetID TargetID TargetType)" {

            $script:TDConnected = $true

            $Assignthis = [PSCustomObject]@{
                AssetID = '12341234-1234-1234-1234-1234567890AB'
                TargetID = '12341234-1234-1234-1234-1234567890AB'
                TargetType = 'branch'
            }

            $Assignment = ($Assignthis | Add-Assignment)
            $Assignment | Should -Not -BeNullOrEmpty

        }

        It "Accepts TargetType of branch" {

            Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
            $script:TDConnected = $true

            $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'branch'
            $Assignment | Should -Not -BeNullOrEmpty

        }

        It "Accepts TargetType of person" {

            Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
            $script:TDConnected = $true

            $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'person'
            $Assignment | Should -Not -BeNullOrEmpty

        }

        It "Accepts TargetType of persongroup" {

            Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
            $script:TDConnected = $true

            $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'persongroup'
            $Assignment | Should -Not -BeNullOrEmpty

        }

        It "Accepts TargetType of incident" {

            Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
            $script:TDConnected = $true

            $Assignment = Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'incident'
            $Assignment | Should -Not -BeNullOrEmpty

        }

        It "Accepts pipeline input (AssetID LocationID BranchID)" {

            #Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{modified = $true;linkErrors = @(@{});unlinkErrors = @(@{})}) }
            $script:TDConnected = $true

            $Assignthis = [PSCustomObject]@{
                AssetID = '12341234-1234-1234-1234-1234567890AB'
                LocationID = '12341234-1234-1234-1234-1234567890AB'
                BranchID = '12341234-1234-1234-1234-1234567890AB'
            }

            $Assignment = ($Assignthis | Add-Assignment)
            $Assignment | Should -Not -BeNullOrEmpty

        }

        It "Should throw when client is disconnected" {

            #Mock -CommandName  Get-APIResponse -MockWith {return (New-Object -TypeName psobject -ArgumentList @{name='asset'}) }
            $script:TDConnected = $false

            {Add-Assignment -AssetID '12341234-1234-1234-1234-1234567890AB' -TargetID '12341234-1234-1234-1234-1234567890AB' -TargetType 'branch'} | Should -Throw
            
        }

    }
}