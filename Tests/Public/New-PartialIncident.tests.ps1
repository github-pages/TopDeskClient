Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

    Describe New-PartialIncident {    
        InModuleScope -ModuleName TopDeskClient {
    
            $FunctionName = 'New-PartialIncident'
    
            Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }
    
            Context "Connection state" {
    
                It "Should throw when client is disconnected" {
                    $script:TDConnected = $false
                    { New-PartialIncident -mainIncident 'A1234567-4444-4444-4444-121212121212' } | Should -Throw
                }
    
                It "Should NOT have performed any API calls" {
                    Assert-MockCalled -CommandName Get-APIResponse -Times 0
                }
    
            }
    
            Context "Pipeline input" {
                $script:TDConnected = $true
    
            }
    
            Context "Calling with parameters" {
                $script:TDConnected = $true
    
            }
    
            Context "Parameters" {

                Context "briefDescription" {

                    $param = (Get-Command $FunctionName).Parameters['briefDescription']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "request" {

                    $param = (Get-Command $FunctionName).Parameters['request']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "action" {

                    $param = (Get-Command $FunctionName).Parameters['action']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "actionInvisibleForCaller" {

                    $param = (Get-Command $FunctionName).Parameters['actionInvisibleForCaller']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'boolean'
                    }

                }

                Context "entryType" {

                    $param = (Get-Command $FunctionName).Parameters['entryType']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "categoryID" {

                    $param = (Get-Command $FunctionName).Parameters['categoryID']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'byID'
                        $param.ParameterSets.byID.IsMandatory | Should -Be $false
                        $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "categoryName" {

                    $param = (Get-Command $FunctionName).Parameters['categoryName']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "subcategoryID" {

                    $param = (Get-Command $FunctionName).Parameters['subcategoryID']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'byID'
                        $param.ParameterSets.byID.IsMandatory | Should -Be $false
                        $param.ParameterSets.byID.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "subcategoryName" {

                    $param = (Get-Command $FunctionName).Parameters['subcategoryName']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "externalNumber" {

                    $param = (Get-Command $FunctionName).Parameters['externalNumber']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "mainIncident" {

                    $param = (Get-Command $FunctionName).Parameters['mainIncident']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $true
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "duration" {

                    $param = (Get-Command $FunctionName).Parameters['duration']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "targetDate" {

                    $param = (Get-Command $FunctionName).Parameters['targetDate']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'DateTime'
                    }

                }

                Context "sla" {

                    $param = (Get-Command $FunctionName).Parameters['sla']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "onHold" {

                    $param = (Get-Command $FunctionName).Parameters['onHold']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'boolean'
                    }

                }

                Context "operator" {

                    $param = (Get-Command $FunctionName).Parameters['operator']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "operatorGroup" {

                    $param = (Get-Command $FunctionName).Parameters['operatorGroup']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "supplier" {

                    $param = (Get-Command $FunctionName).Parameters['supplier']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "processingStatus" {

                    $param = (Get-Command $FunctionName).Parameters['processingStatus']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "responded" {

                    $param = (Get-Command $FunctionName).Parameters['responded']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'boolean'
                    }

                }

                Context "responseDate" {

                    $param = (Get-Command $FunctionName).Parameters['responseDate']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'DateTime'
                    }

                }

                Context "completed" {

                    $param = (Get-Command $FunctionName).Parameters['completed']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'boolean'
                    }

                }

                Context "completedDate" {

                    $param = (Get-Command $FunctionName).Parameters['completedDate']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'DateTime'
                    }

                }

                Context "closureCode" {

                    $param = (Get-Command $FunctionName).Parameters['closureCode']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "costs" {

                    $param = (Get-Command $FunctionName).Parameters['costs']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'single'
                    }

                }

                Context "feedbackRating" {

                    $param = (Get-Command $FunctionName).Parameters['feedbackRating']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'int'
                    }

                }

                Context "feedbackMessage" {

                    $param = (Get-Command $FunctionName).Parameters['feedbackMessage']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "majorCallObject" {

                    $param = (Get-Command $FunctionName).Parameters['majorCallObject']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "optionalFields1" {

                    $param = (Get-Command $FunctionName).Parameters['optionalFields1']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'hashtable'
                    }

                }

                Context "optionalFields2" {

                    $param = (Get-Command $FunctionName).Parameters['optionalFields2']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'hashtable'
                    }

                }

                Context "externalLinkID" {

                    $param = (Get-Command $FunctionName).Parameters['externalLinkID']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'string'
                    }

                }

                Context "externalLinkType" {

                    $param = (Get-Command $FunctionName).Parameters['externalLinkType']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'int'
                    }

                }

                Context "externalLinkDate" {

                    $param = (Get-Command $FunctionName).Parameters['externalLinkDate']
    
                    It "Should maintain compatibility" {
                        $param.ParameterSets.Keys | Should -Contain 'Default'
                        $param.ParameterSets.Default.IsMandatory | Should -Be $false
                        $param.ParameterSets.Default.ValueFromPipelineByPropertyName | Should -Be $false
                        $param.ParameterType.Name | Should -Be 'DateTime'
                    }

                }

            }

        }
    }