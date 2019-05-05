Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "ConvertTo-ISODate" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'ConvertTo-ISODate'

        Context "Pipeline input" {
            $testDate1 = [datetime]::Now
            $testRes1 = $testDate1.ToString('o').SubString(0,23) + $testDate1.ToString('zzz').Replace(':','')
            $testDate2 = [datetime] '2019-Jan-11'
            $testRes2 = '2019-01-11T00:00:00.000' + $testDate2.ToString('zzz').Replace(':','')
            $ISODate1 = $testDate1 | ConvertTo-ISODate
            $ISODate2 = $testDate2 | ConvertTo-ISODate


            It "Should convert the date to TopDesk compatible ISO8601 format string" {
                $ISODate1 | Should -BeOfType [string]
                $ISODate1 | Should -Be $testRes1
            }

            It "Should convert using local timezone" {
                $ISODate2 | Should -BeOfType [string]
                $ISODate2 | Should -Be $testRes2
            }
        }

        Context "Calling with Parameters" {

            $testDate1 = [datetime]::Now
            $testRes1 = $testDate1.ToString('o').SubString(0,23) + $testDate1.ToString('zzz').Replace(':','')
            $TestDate2 = [datetime] '2019-Jan-11'
            $testRes2 = '2019-01-11T00:00:00.000' + $testDate2.ToString('zzz').Replace(':','')
            $ISODate1 = (ConvertTo-ISODate -Date $testDate1)
            $ISODate2 = (ConvertTo-ISODate -Date $TestDate2)

            It "Should convert the date to TopDesk compatible ISO8601 format string" {
                $ISODate1 | Should -BeOfType [string]
                $ISODate1 | Should -Be $testRes1
            }

            It "Should convert using local timezone" {
                $ISODate2 | Should -BeOfType [string]
                $ISODate2 | Should -Be $testRes2
            }

        }

        Context "Parameters" {
            Context "Date" {

                $param = (Get-Command $FunctionName).Parameters['Date']

                It "Should maintain compatiblity" {

                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipeline | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'DateTime'
                    
                }
            }
        }
    }
}
