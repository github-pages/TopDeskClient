
Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe New-OptionalFields {

    InModuleScope -ModuleName TopDeskClient {
        
        $FunctionName = 'New-OptionalField'

        Context "Pipeline input" {
            
            It "Creates hashtable when piped boolean values" {
                [PSCustomObject] $booleanValues = [PSCustomObject] @{
                    'boolean' = $true,$true,$false
                    'number' = 1,2,33,21
                }
                $MyFreeFields = ($booleanValues | New-OptionalField)

                $MyFreeFields | Should -BeOfType [hashtable]
                $MyFreeFields.optionalFields1 | Should -HaveCount 7
                $MyFreeFields.optionalFields1.Values[0] | Should -Be $true
                $MyFreeFields.optionalFields1.Values[1] | Should -Be $true
                $MyFreeFields.optionalFields1.Values[2] | Should -Be $false
                
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

            Context "boolean" {

                $param = (Get-Command $FunctionName).Parameters['boolean']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $false
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean[]'
                }

            }

        }

    }
}
