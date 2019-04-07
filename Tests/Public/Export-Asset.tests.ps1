Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe Export-Asset {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Export-Asset'
        $Assets = [PSCustomObject]@{
            Name = 'MyAsset'
            id = '12341234-1234-1234-1234-1234567890AB'
        }

        Context "Export Assets in Binary format" {

            $FilePath = "$TestDrive\export\myassets.bin"

            It "Should export assets in binary format" {
                $result = Export-Asset -FilePath $FilePath -Assets $Assets
                $result | Should -BeNullOrEmpty
            }

            It "Should contain the exported asset info" {
                $FilePath | Should -Exist
                $FilePath | Should -FileContentMatch 'MyAsset'
                $FilePath | Should -FileContentMatch '12341234-1234-1234-1234-1234567890AB'
            }

        }

        Context "Export Assets in JSON format" {

            $FilePath = "$TestDrive\export\myassets.json"

            It "Should export assets in json format" {
                $result = Export-Asset -FilePath $FilePath -Assets $Assets -json
                $result | Should -BeNullOrEmpty
            }

            It "Should contain valid json" {
                $jsonasset = (Get-Content -Path $FilePath) | ConvertFrom-Json
                $jsonasset.Name | Should -BeExactly 'MyAsset'
                $jsonasset.id | Should -BeExactly '12341234-1234-1234-1234-1234567890AB'
            }

            It "Should contain the exported asset info" {
                $FilePath | Should -Exist
                $FilePath | Should -FileContentMatch 'MyAsset'
                $FilePath | Should -FileContentMatch '12341234-1234-1234-1234-1234567890AB'
            }

        }

        Context "Export Assets in CSV format" {

            $FilePath = "$TestDrive\export\myassets.csv"

            It "Should export assets in csv format" {
                $result = Export-Asset -FilePath $FilePath -Assets $Assets -csv
                $result | Should -BeNullOrEmpty
            }

            It "Should contain valid csv" {
                $csvasset = (Import-Csv -Path $FilePath)
                $csvasset.Name | Should -BeExactly 'MyAsset'
                $csvasset.id | Should -BeExactly '12341234-1234-1234-1234-1234567890AB'
            }

            It "Should contain the exported asset info" {
                $FilePath | Should -Exist
                $FilePath | Should -FileContentMatch 'MyAsset'
                $FilePath | Should -FileContentMatch '12341234-1234-1234-1234-1234567890AB'
            }

        }

        Context "Parameters" {

            Context "ParameterSets" {
                
                Context "Default" {

                    It "Should have a parameterset named Default" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'Default' | Should -Be $true
                    }

                    It "Should be the default parameterset" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).IsDefault | Should -Be $true
                    }

                    It "Should have 2 parameters in Default" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'FilePath'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'Default'}).Parameters.Name | Should -Contain 'Assets'
                    }

                }

                Context "json" {

                    It "Should have a parameterset name Json" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'json' | Should -Be $true
                    }

                    It "Should have 3 parameters in json" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'json'}).Parameters.Name | Should -Contain 'FilePath'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'json'}).Parameters.Name | Should -Contain 'Assets'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'json'}).Parameters.Name | Should -Contain 'json'
                    }

                }

                Context "csv" {

                    It "Should have a parameterset name csv" {
                        (Get-Command $FunctionName).ParameterSets.Name -icontains 'csv' | Should -Be $true
                    }

                    It "Should have 3 parameters in csv" {
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'csv'}).Parameters.Name | Should -Contain 'FilePath'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'csv'}).Parameters.Name | Should -Contain 'Assets'
                        (Get-Command $FunctionName).ParameterSets.Where({$_.Name -eq 'csv'}).Parameters.Name | Should -Contain 'csv'
                    }

                }

            }

            Context "Mandatory parameters" {

                It "FilePath should be mandatory" {
                    #((Get-Command $FunctionName).Parameters['FilePath'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    Get-Command $FunctionName | Should -HaveParameter FilePath -Mandatory
                }

                It "Assets should be mandatory" {
                    #((Get-Command $FunctionName).Parameters['Assets'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    Get-Command $FunctionName | Should -HaveParameter Assets -Mandatory
                }

                It "json should NOT be mandatory" {
                    #((Get-Command $FunctionName).Parameters['json'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    Get-Command  $FunctionName | Should -HaveParameter json -Not -Mandatory
                }

                It "csv should NOT be mandatory" {
                    #((Get-Command $FunctionName).Parameters['csv'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($true)
                    Get-Command $FunctionName | Should   -HaveParameter csv -Not -Mandatory
                }

                <# It "Force should NOT be mandatory" {
                    ((Get-Command $FunctionName).Parameters['Force'].Attributes | Where-Object { $_ -is [parameter] }).Mandatory | Should -Be @($false)
                } #>

            }

            Context "Parameter Validation" {
            
                Context "FilePath" {
    
                    It "Should be in all Parameter sets" {
                        (Get-Command $FunctionName).Parameters['FilePath'].ParameterSets.ContainsKey('__AllParameterSets') | Should -Be $true
                    }
    
                    It "Should have an alias Path" {
                        (Get-Command $FunctionName).Parameters['FilePath'].Aliases.Contains('Path') | Should -Be $true
                    }

                    It "Should have an alias File" {
                        (Get-Command $FunctionName).Parameters['FilePath'].Aliases.Contains('File') | Should -Be $true
                    }
    
                    It "Should accept a string" {
                        #(Get-Command $FunctionName).Parameters['FilePath'].ParameterType.Name | Should -Be String
                        Get-Command $FunctionName | Should -HaveParameter -ParameterName FilePath -Type [String]
                    }
    
                }
    
                Context "Assets" {

                    It "Should be in all Parameter sets" {
                        (Get-Command $FunctionName).Parameters['Assets'].ParameterSets.ContainsKey('__AllParameterSets') | Should -Be $true
                    }

                    It "Should have an alias object" {
                        (Get-Command $FunctionName).Parameters['Assets'].Aliases.Contains('object') | Should -Be $true
                    }
    
                    It "Should accept a psobject" {
                        #(Get-Command $FunctionName).Parameters['Assets'].ParameterType.Name | Should -Be psobject
                        Get-Command $FunctionName | Should -HaveParameter -ParameterName Assets -Type [psobject]
                    }
    
                }
    
                Context "json" {
    
                    It "Should be a switch" {
                        #(Get-Command $FunctionName).Parameters['json'].SwitchParameter | Should -Be $true
                        Get-Command $FunctionName | Should -HaveParameter -ParameterName json -Type [switch]
                    }

                    It "Should be in the json parameterset" {
                        (Get-Command $FunctionName).Parameters['json'].ParameterSets.ContainsKey('json') | Should -Be $true
                    }

                    It "Should only be in one parameterset" {
                        (Get-Command $FunctionName).Parameters['json'].ParameterSets.Count | Should -HaveCount 1
                    }
    
                }
    
                Context "csv" {
    
                    It "Should accept a switch" {
                        #(Get-Command $FunctionName).Parameters['csv'].SwitchParameter | Should -Be $true
                        Get-Command $FunctionName | Should -HaveParameter -ParameterName csv -Type [switch]
                    }

                    It "Should be in the csv parameterset" {
                        (Get-Command $FunctionName).Parameters['csv'].ParameterSets.ContainsKey('csv') | Should -Be $true
                    }

                    It "Should only be in one parameterset" {
                        (Get-Command $FunctionName).Parameters['csv'].ParameterSets.Count | Should -HaveCount 1
                    }
    
                }
    
            }
        }

    }
}
