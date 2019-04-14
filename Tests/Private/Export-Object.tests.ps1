Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Export-Object" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Export-Object'

        Context "Exporting" {
            $pobj1 = [PSCustomObject]@{
                Prop1 = 'Test1'
                Prop2 = 'Test2'
            }
            $exportdir1 = "$TestDrive\Test1"
            $exportfile1 = 'test1.bin'
            
            if(!(Test-Path $exportdir1)) {
                New-Item -Path $exportdir1 -ItemType Directory
            }

            Export-Object -FilePath $exportdir1 -ExportObject $pobj1 -FileName $exportfile1

            It "Exports an object" {
                "$exportdir1\$exportfile1" | Should -Exist
            }

            $test1 = Import-Object -FilePath "$exportdir1\$exportfile1"
            It "Contains the exported object" {
                $test1.Prop1 | Should -Be 'Test1'
                $test1.Prop2 | Should -Be 'Test2'
            }
        }

        Context "Parameters" {
            
            Context "FilePath" {
                $param = (Get-Command $FunctionName).Parameters['FilePath']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'Default'
                    $param.ParameterSets.Default.IsMandatory | Should -Be $true
                    $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'Path'
                }
            }

            Context "LiteralPath" {
                $param = (Get-Command $FunctionName).Parameters['LiteralPath']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain 'LiteralPath'
                    $param.ParameterSets.LiteralPath.IsMandatory | Should -Be $true
                    $param.ParameterSets.LiteralPath.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'PSPath'
                }
            }

            Context "ExportObject" {
                $param = (Get-Command $FunctionName).Parameters['ExportObject']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'psobject[]'
                    $param.Aliases | Should -Contain 'Object'
                }
            }

            Context "FileName" {
                $param = (Get-Command $FunctionName).Parameters['FileName']

                It "Should maintain compatiblity" {
                    $param.ParameterSets.Keys | Should -Contain '__AllParametersets'
                    $param.ParameterSets.__AllParameterSets.IsMandatory | Should -Be $true
                    $param.ParameterSets.__AllParameterSets.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'Name'
                }
            }
        } 
    }
}
