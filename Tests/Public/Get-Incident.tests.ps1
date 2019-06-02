Import-Module $PSScriptRoot\..\..\TopDeskClient\TopDeskClient.psd1 -Force

Describe "Get-Incident" {

    InModuleScope -ModuleName TopDeskClient {

        $FunctionName = 'Get-Incident'

        Mock -CommandName  Get-APIResponse -MockWith { return 'catch-all' }

        Context "Connection state" {

            It "Should throw when client is disconnected" {
                $script:TDConnected = $false
                { Get-Incident -Number '1' } | Should -Throw
            }

            It "Should NOT have performed any API calls" {
                Assert-MockCalled -CommandName Get-APIResponse -Times 0
            }

        }

        Context "Pipeline input" {
            $script:TDConnected = $true

            Context "Incident by Number" {
                $pobj1 = [PSCustomObject]@{
                    Number = '1'
                }
                $param1 = $pobj1.Number
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyNumber' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents/number/' + $param1.Trim() } -Verifiable
                $Incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped an Incident Number" {
                    $Incident | Should -Not -BeNullOrEmpty
                    $Incident | Should -Be 'IncidentbyNumber'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Asset" {
                $pobj1 = [PSCustomObject]@{
                    AssetName = '1234567'
                }
                $param1 = $pobj1.AssetName
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyAssetName' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&object_name=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped an Asset Name" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyAssetName'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Caller" {
                $pobj1 = [PSCustomObject]@{
                    caller = '123123'
                }
                $param1 = $pobj1.caller
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyCaller' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&caller=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped an Caller id" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyCaller'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Operator" {
                $pobj1 = [PSCustomObject]@{
                    operator = '123789'
                }
                $param1 = $pobj1.operator
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyOperator' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&operator=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped an Operator ID" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyOperator'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Processing Status" {
                $pobj1 = [PSCustomObject]@{
                    processing_status = '888888'
                }
                $param1 = $pobj1.processing_status
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyProcessingStatus' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&processing_status=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped a Processing Status" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyProcessingStatus'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident with Start" {
                $pobj1 = [PSCustomObject]@{
                    start = '3'
                }
                $param1 = $pobj1.start
                Mock -CommandName Get-APIResponse -MockWith { return 'Incidentwithstart' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&start=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped a start number" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'Incidentwithstart'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident with Page Size" {
                $pobj1 = [PSCustomObject]@{
                    page_size = '12'
                }
                $param1 = $pobj1.page_size
                Mock -CommandName Get-APIResponse -MockWith { return 'Incidentwithpage_size' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&page_size=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped a Page Size" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'Incidentwithpage_size'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Target End Date" {
                $pobj1 = [PSCustomObject]@{
                    target_date_end = (Get-Date)
                }
                $param1 = $pobj1.target_date_end.ToString("yyyy-MM-dd")
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyTargetEndDate' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&target_date_end=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped a Target End Date" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyTargetEndDate'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident with Fields" {
                $pobj1 = [PSCustomObject]@{
                    fields = 'Number','status'
                }
                $param1 = $pobj1.fields -join ','
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentwithFields' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&$fields=' + $param1 + '&use_standard_response=true' } -Verifiable
                
                $incident = ($pobj1 | Get-Incident)

                It "Returns an incident when piped Fields" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentwithFields'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

        }

        Context "Calling with parameters" {
            
            $script:TDConnected = $true

            Context "Incident by Number" {
                $param1 = '1'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyNumber' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents/number/' + $param1.Trim() } -Verifiable
                $Incident = (Get-Incident -Number $param1)

                It "Should return a value" {
                    $Incident | Should -Not -BeNullOrEmpty
                    $Incident | Should -Be 'IncidentbyNumber'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }
            }

            Context "Incident by Asset" {
                $param1 = '1234567'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyAssetName' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&object_name=' + $param1.Trim() + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -AssetName $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyAssetName'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Caller" {
                $param1 = '123123'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyCaller' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&caller=' + $param1.Trim() + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -caller $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyCaller'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Operator" {
                $param1 = '123789'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyOperator' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&operator=' + $param1.Trim() + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -operator $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyOperator'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Processing Status" {
                $param1 = '888888'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyProcessingStatus' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&processing_status=' + $param1.Trim() + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -processing_status $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyProcessingStatus'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident with Start" {
                $param1 = '3'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentwithStart' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&start=' + $param1.Trim() + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -start $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentwithStart'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident with Page Size" {
                $param1 = '12'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentwithPageSize' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&page_size=' + $param1.Trim() + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -page_size $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentwithPageSize'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Target End Date" {
                $param1 = (Get-Date).ToString("yyyy-MM-dd")
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyTargetDate' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&target_date_end=' + $param1 + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -target_date_end $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyTargetDate'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

            Context "Incident by Fields" {
                $param1 = 'Number','Status'
                Mock -CommandName Get-APIResponse -MockWith { return 'IncidentbyFields' } -ParameterFilter { $_uri -and $_uri -eq '/tas/api/incidents?&$fields=' + ($param1 -join ',') + '&use_standard_response=true' } -Verifiable
                $incident = (Get-Incident -fields $param1)

                It "Should return a value" {
                    $incident | Should -Not -BeNullOrEmpty
                    $incident | Should -Be 'IncidentbyFields'
                }

                It "Should perform an API call" {
                    Assert-VerifiableMock
                }

            }

        }

        Context "Parameters" {

            Context "Number" {
                $param = (Get-Command $FunctionName).Parameters['Number']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'Number'
                    $param.ParameterSets.Number.IsMandatory | Should -Be $true
                    $param.ParameterSets.Number.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'IncidentNumber'
                }
            }

            Context "AssetName" {
                $param = (Get-Command $FunctionName).Parameters['AssetName']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string'
                    $param.Aliases | Should -Contain 'AssetID'
                }
            }

            Context "caller" {
                $param = (Get-Command $FunctionName).Parameters['caller']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "operator_group" {
                $param = (Get-Command $FunctionName).Parameters['operator_group']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "operator" {
                $param = (Get-Command $FunctionName).Parameters['operator']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "processing_status" {
                $param = (Get-Command $FunctionName).Parameters['processing_status']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "main_incident_id" {
                $param = (Get-Command $FunctionName).Parameters['main_incident_id']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "status" {
                $param = (Get-Command $FunctionName).Parameters['status']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "caller_branch" {
                $param = (Get-Command $FunctionName).Parameters['caller_branch']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "object_id" {
                $param = (Get-Command $FunctionName).Parameters['object_id']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "linked_object_id" {
                $param = (Get-Command $FunctionName).Parameters['linked_object_id']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "linked_object_name" {
                $param = (Get-Command $FunctionName).Parameters['linked_object_name']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "external_link_id" {
                $param = (Get-Command $FunctionName).Parameters['external_link_id']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "external_link_type" {
                $param = (Get-Command $FunctionName).Parameters['external_link_type']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "id" {
                $param = (Get-Command $FunctionName).Parameters['id']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "external_number" {
                $param = (Get-Command $FunctionName).Parameters['external_number']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }

            Context "start" {
                $param = (Get-Command $FunctionName).Parameters['start']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'int32'
                }
            }

            Context "page_size" {
                $param = (Get-Command $FunctionName).Parameters['page_size']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'int32'
                }
            }

            Context "order_by" {
                $param = (Get-Command $FunctionName).Parameters['order_by']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'hashtable'
                }
            }

            Context "completed" {
                $param = (Get-Command $FunctionName).Parameters['completed']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                }
            }

            Context "resolved" {
                $param = (Get-Command $FunctionName).Parameters['resolved']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                }
            }

            Context "major_call" {
                $param = (Get-Command $FunctionName).Parameters['major_call']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                }
            }

            Context "archived" {
                $param = (Get-Command $FunctionName).Parameters['archived']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'boolean'
                }
            }

            Context "target_date_start" {
                $param = (Get-Command $FunctionName).Parameters['target_date_start']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "target_date_end" {
                $param = (Get-Command $FunctionName).Parameters['target_date_end']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "call_date_start" {
                $param = (Get-Command $FunctionName).Parameters['call_date_start']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "call_date_end" {
                $param = (Get-Command $FunctionName).Parameters['call_date_end']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "creation_date_start" {
                $param = (Get-Command $FunctionName).Parameters['creation_date_start']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "creation_date_end" {
                $param = (Get-Command $FunctionName).Parameters['creation_date_end']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "modification_date_start" {
                $param = (Get-Command $FunctionName).Parameters['modification_date_start']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "modification_date_end" {
                $param = (Get-Command $FunctionName).Parameters['modification_date_end']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "closed_date_start" {
                $param = (Get-Command $FunctionName).Parameters['closed_date_start']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "closed_date_end" {
                $param = (Get-Command $FunctionName).Parameters['closed_date_end']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'datetime'
                }
            }

            Context "fields" {
                $param = (Get-Command $FunctionName).Parameters['fields']

                It "Should maintain compatibility" {
                    $param.ParameterSets.Keys | Should -Contain 'ByQuery'
                    $param.ParameterSets.ByQuery.IsMandatory | Should -Be $false
                    $param.ParameterSets.byQuery.ValueFromPipelineByPropertyName | Should -Be $true
                    $param.ParameterType.Name | Should -Be 'string[]'
                }
            }
        }
    }
}