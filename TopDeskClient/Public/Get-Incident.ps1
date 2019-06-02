function Get-Incident {
  <#
    .Synopsis

      Short description

    .DESCRIPTION

      Long description

    .PARAMETER <Parameter-Name>

      The description of a parameter.

    .EXAMPLE

      Example of how to use this cmdlet

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      The .NET Framework type of the objects that the cmdlet returns.
      You can also include a description of the returned objects.

    .NOTES

      Additional information about the function or script.

    .LINK

        [Get-Incident](https://github.com/rbury/TopDeskClient/Docs/Get-Incident.md)

  #>
    [CmdletBinding(DefaultParameterSetName='Number',
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-Incident.md',
                ConfirmImpact='Medium')]
    [OutputType([PSObject], ParameterSetName = "Number")]

    Param (

        # The incident number
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'Number')]
        [ValidateNotNullOrEmpty()]
        [Alias('IncidentNumber')]
        [string]
        $Number,

        # Retrieve only incidents that have one of the specified objects set (by object name)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateNotNullOrEmpty()]
        [Alias('AssetID')]
        [string]
        $AssetName,

        # Retrieve only incidents reported by one of these caller ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $caller,

        # Retrieve only incidents assigned to one of these operator group ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $operator_group,

        # Retrieve only incidents assigned to one of these operator ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $operator,

        # Retrieve only incidents with one of these processing status ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $processing_status,

        # Retrieve only incidents that have one of these main incident ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $main_incident_id,

        # Retrieve only firstLine/secondLine/partial incidents
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateSet('firstLine', 'secondLine', 'partial')]
        [string[]]
        $status,

        # Retrieve only incidents reported by callers from one of these branch ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $caller_branch,

        # Retrieve only incidents that have one of the specified objects set (by id)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $object_id,

        # Retrieve only incidents that are linked to one of the specified objects (by id)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $linked_object_id,

        # Retrieve only incidents that are linked to one of the specified objects (by object name)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $linked_object_name,

        # Retrieve only incidents with external link id equal to one of these values
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $external_link_id,

        # Retrieve only incidents with external link type equal to one of these values
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $external_link_type,

        # Retrieve one or more incidents with the given ids
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $id,

        # Retrieve one or more incidents with the given external numbers
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [string[]]
        $external_number,

        # The offset at which to start listing the incidents at
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateNotNullOrEmpty()]
        [int]
        $start,

        # The amount of incidents to be returned per request ( Default 10, Max 10 000 )
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateNotNullOrEmpty()]
        [int]
        $page_size,

        # Order the retrieved incidents, Default is sorted by creation date, descending (newest first)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $order_by,

        # Retrieve only incidents that are completed / not completed
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [bool]
        $completed,

        # Retrieve only incidents that are closed / not closed
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [bool]
        $closed,

        # Retrieve only incidents that are resolved depending on the setting
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [bool]
        $resolved,

        # Retrieve only incidents that are major calls / not major calls
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [bool]
        $major_call,

        # Whether to return archived incidents
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [bool]
        $archived,

        # Retrieve only incidents with target date greater or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $target_date_start,

        # Retrieve only incidents with target date smaller or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $target_date_end,

        # Retrieve only incidents with call date greater or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $call_date_start,

        # Retrieve only incidents with call date smaller or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $call_date_end,

        # Retrieve only incidents with creation date greater or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $creation_date_start,

        # Retrieve only incidents with creation date smaller or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $creation_date_end,

        # Retrieve only incidents with modification date greater or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $modification_date_start,

        # Retrieve only incidents with modification date smaller or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $modification_date_end,

        # Retrieve only incidents with closed date greater or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $closed_date_start,

        # Retrieve only incidents with closed date smaller or equal to this day
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [datetime]
        $closed_date_end,

        # Return only specified fields.
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByQuery')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $fields

    )

    begin{

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_headerslist = @{
            'Content-Type' = 'application/json'
        }

    }
    
    process {

        switch ($PSCmdlet.ParameterSetName) {

            'Number' {

                $_uri = $script:tdURI + '/tas/api/incidents/number/' + $Number.Trim()
                break

            }

            'ByQuery' {
                $_uri = $script:tdURI + '/tas/api/incidents?' #object_name=' + $AssetName.Trim()

                foreach ($item in $PSBoundParameters.Keys) {

                    switch ($item) {

                        'AssetName' {
                            $_uri += '&object_name=' + $AssetName.Trim()
                            break
                        }

                        'page_size' {   
                            $_uri += '&page_size=' + $page_size
                            break
                        }
        
                        'start' {
                            $_uri += '&start=' + $start
                            break
                        }
        
                        'order_by' {
                            $_uri += '&order_by='
                            $orderstring = ''
                            foreach ($item in $order_by.Keys) {
                                $orderstring += $item + '+' + $order_by.$item + ','
                            }
                            
                            $_uri += ($orderstring -replace ".$")
                            break
                        }
        
                        'completed' {
                            $_uri += '&completed=' + $completed
                            break
                        }
        
                        'closed' {
                            $_uri += '&closed=' + $closed
                            break 
                        }
        
                        'resolved' {
                            $_uri += '&resolved=' + $resolved
                            break 
                        }
        
                        'major_call' {
                            $_uri += '&major_call=' + $major_call
                            break
                        }
        
                        'archived' {
                            $_uri += '&archived=' + $archived
                            break
                        }
        
                        'target_date_start' {
                            $_uri += '&target_date_start=' + $target_date_start.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'target_date_end' {
                            $_uri += '&target_date_end=' + $target_date_end.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'call_date_start' {
                            $_uri += '&call_date_start=' + $call_date_start.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'call_date_end' {
                            $_uri += '&call_date_end=' + $call_date_end.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'creation_date_start' {
                            $_uri += '&creation_date_start=' + $creation_date_start.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'creation_date_end' {
                            $_uri += '&creation_date_end=' + $creation_date_end.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'modification_date_start' {
                            $_uri += '&modification_date_start=' + $modification_date_start.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'modification_date_end' {
                            $_uri += '&modification_date_end=' + $modification_date_end.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'closed_date_start' {
                            $_uri += '&closed_date_start=' + $closed_date_start.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'closed_date_end' {
                            $_uri += '&closed_date_end=' + $closed_date_end.ToString("yyyy-MM-dd")
                            break
                        }
        
                        'fields' {
                            $_uri += '&fields=' + ($fields -join ',')
                            break
                        }
        
                        'caller' {
                            foreach ($item in $caller) {
                                $_uri += '&caller=' + $item
                            }
                            break
                        }

                        'operator_group' {
                            foreach ( $item in $operator_group) {
                                $_uri += '&operator_group=' + $item
                            }
                            break
                        }

                        'operator' {
                            foreach ( $item in $operator) {
                                $_uri += '&operator=' + $item
                            }
                            break
                        }

                        'processing_status' {
                            foreach ( $item in $processing_status) {
                                $_uri += '&processing_status=' + $item
                            }
                            break
                        }

                        'main_incident_id' {
                            foreach ( $item in $main_incident_id) {
                                $_uri += '&main_incident_id=' + $item
                            }
                            break
                        }

                        'status' {
                            foreach ( $item in $status ) {
                                $_uri += '&status=' + $status
                            }
                        }
                        
                        'caller_branch' {
                            foreach ( $item in $caller_branch) {
                                $_uri += '&caller_branch=' + $item
                            }
                            break
                        }

                        'object_id' {
                            foreach ( $item in $object_id) {
                                $_uri += '&object_id=' + $item
                            }
                            break
                        }

                        'linked_object_id' {
                            foreach ( $item in $linked_object_id) {
                                $_uri += '&linked_object_id=' + $item
                            }
                            break
                        }
        
                        'linked_object_name' {
                            foreach ( $item in $linked_object_name) {
                                $_uri += '&linked_object_name=' + $item
                            }
                            break
                        }

                        'external_link_id' {
                            foreach ( $item in $external_link_id) {
                                $_uri += '&external_link_id=' + $item
                            }
                            break
                        }

                        'external_link_type' {
                            foreach ( $item in $external_link_type) {
                                $_uri += '&external_link_type=' + $item
                            }
                            break
                        }

                        'id' {
                            foreach ( $item in $id) {
                                $_uri += '&id=' + $item
                            }
                            break
                        }

                        'external_number' {
                            foreach ( $item in $external_number) {
                                $_uri += '&external_number=' + $item
                            }
                            break
                        }

                        Default {}
                    }
                }
                break
            }
        }

        $_uri += '&use_standard_response=true'
        Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential
    }

    end {}

}
