
Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe New-OptionalFields {

    InModuleScope -ModuleName TopDeskClient {
        
        $FunctionName = 'New-OptionalField'

        Context "Pipeline input" {
            
            It "Creates hashtable when piped boolean values" {
                [PSCustomObject] $booleanValues = [PSCustomObject] @{
                    'boolean' = $true,$true,$false
                }
                $MyFreeFields = ($booleanValues | New-OptionalField)

                $MyFreeFields | Should -BeOfType [hashtable]
                $MyFreeFields.optionalFields1 | Should -HaveCount 3
                $MyFreeFields.optionalFields1.Values[0] | Should -Be $true
                $MyFreeFields.optionalFields1.Values[1] | Should -Be $true
                $MyFreeFields.optionalFields1.Values[2] | Should -Be $false
                
            }

            It "Creates hashtable for field 2 when piped values" {
                [PSCustomObject] $field2values = [PSCustomObject] @{
                    'optionalField' = 2
                    'boolean' = $true,$true,$false
                    'number' = 33,21
                    'date' = '2019-05-07','2019-05-05'
                    'text' = 'text1','text2'
                    'memo' = 'memo1','memo2'
                    'searchlist' = 'search1','search2'
                }

                $MyFreeFields = ($field2values | New-OptionalField)

                $MyFreeFields | Should -BeOfType [hashtable]
                $MyFreeFields.optionalFields2 | Should -HaveCount 13
                $MyFreeFields.optionalFields2.Keys[0] | Should -Be 'boolean1'
                $MyFreeFields.optionalFields2.Keys[1] | Should -Be 'boolean2'
                $MyFreeFields.optionalFields2.Keys[2] | Should -Be 'boolean3'
                $MyFreeFields.optionalFields2.Values[0] | Should -Be $true
                $MyFreeFields.optionalFields2.Values[1] | Should -Be $true
                $MyFreeFields.optionalFields2.Values[2] | Should -Be $false
                $MyFreeFields.optionalFields2.Keys[3] | Should -Be 'number1'
                $MyFreeFields.optionalFields2.Keys[4] | Should -Be 'number2'
                $MyFreeFields.optionalFields2.Values[3] | Should -Be 33
                $MyFreeFields.optionalFields2.Values[4] | Should -Be 21
                $MyFreeFields.optionalFields2.Keys[5] | Should -Be 'date1'
                $MyFreeFields.optionalFields2.Keys[6] | Should -Be 'date2'
                $MyFreeFields.optionalFields2.Values[5].ToString() | Should -BeLike "2019-05-07*"
                $MyFreeFields.optionalFields2.Values[6].ToString() | Should -BeLike "2019-05-05*"
                $MyFreeFields.optionalFields2.Keys[7] | Should -Be 'text1'
                $MyFreeFields.optionalFields2.Keys[8] | Should -Be 'text2'
                $MyFreeFields.optionalFields2.Values[7] | Should -Be 'text1'
                $MyFreeFields.optionalFields2.Values[8] | Should -Be 'text2'
                $MyFreeFields.optionalFields2.Keys[9] | Should -Be 'memo1'
                $MyFreeFields.optionalFields2.Keys[10] | Should -Be 'memo2'
                $MyFreeFields.optionalFields2.Values[9] | Should -Be 'memo1'
                $MyFreeFields.optionalFields2.Values[10] | Should -Be 'memo2'
                $MyFreeFields.optionalFields2.Keys[11] | Should -Be 'searchlist1'
                $MyFreeFields.optionalFields2.Keys[12] | Should -Be 'searchlist2'
                $MyFreeFields.optionalFields2.Values[11] | Should -Be 'search1'
                $MyFreeFields.optionalFields2.Values[12] | Should -Be 'search2'

            }
        }

        Context "Calling with parameters" {
            
            It "Creates hashtable when provided boolean values" {
            
                $MyFreeFields = (New-OptionalField -boolean $true,$false,$false)

                $MyFreeFields | Should -BeOfType [hashtable]
                $MyFreeFields.optionalFields1 | Should -HaveCount 3
                $MyFreeFields.optionalFields1.Keys[0] | Should -Be 'boolean1'
                $MyFreeFields.optionalFields1.Keys[1] | Should -Be 'boolean2'
                $MyFreeFields.optionalFields1.Keys[2] | Should -Be 'boolean3'             

            }
        }


        Context "Parameters" {

            Context "optionalField" {

                $param = (Get-Command $FunctionName).Parameters['optionalField']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.parameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'int32'
                }
            }

            Context "boolean" {

                $param = (Get-Command $FunctionName).Parameters['boolean']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean[]'
                }

            }

            Context "booleanHash" {

                $param = (Get-Command $FunctionName).Parameters['booleanHash']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.byNumber.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNumber.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }

            }

            Context "number" {

                $param = (Get-Command $FunctionName).Parameters['number']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'single[]'
                }

            }

            Context "numberHash" {

                $param = (Get-Command $FunctionName).Parameters['numberHash']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.byNumber.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNumber.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }

            }

            Context "date" {

                $param = (Get-Command $FunctionName).Parameters['date']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime[]'
                }

            }

            Context "DateHash" {

                $param = (Get-Command $FunctionName).Parameters['DateHash']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.byNumber.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNumber.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }

            }

            Context "text" {

                $param = (Get-Command $FunctionName).Parameters['text']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }

            }

            Context "textHash" {

                $param = (Get-Command $FunctionName).Parameters['textHash']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.byNumber.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNumber.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }

            }

            Context "memo" {

                $param = (Get-Command $FunctionName).Parameters['memo']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }

            }

            Context "memoHash" {

                $param = (Get-Command $FunctionName).Parameters['memoHash']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.byNumber.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNumber.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }

            }

            Context "searchlist" {

                $param = (Get-Command $FunctionName).Parameters['searchlist']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }

            }

            Context "searchlistHash" {

                $param = (Get-Command $FunctionName).Parameters['searchlistHash']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'byNumber'
                    $param.ParameterSets.byNumber.IsMandatory | Should -Be $false
                    $param.ParameterSets.byNumber.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }

            }

        }

    }
}
