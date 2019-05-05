function New-PartialIncident
{
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
    
      The name of a related topic. The value appears on the line below the ".LINK" keyword and must be preceded by a comment symbol # or included in the comment block.
      Repeat the ".LINK" keyword for each related topic.
  #>
    [CmdletBinding(DefaultParameterSetName='Default',
                SupportsShouldProcess=$true,
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/New-PartialIncident.md',
                ConfirmImpact='Medium')]
    [OutputType([String], ParameterSetName = "Default")]
    Param (

        # brief Description of incident
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [ValidateLength(1, 80)]
        [string]
        $briefDescription,

        # initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [string]
        $request,

        # initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [string]
        $action,

        # Make action invisible - Default = $false
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [bool]
        $actionInvisibleForCaller,

        # Entry type by id
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $entryType,

        # Category by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $categoryID,

        # Category by name
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [string]
        $categoryName,

        # Subcategory by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $subcategoryID,

        # Subcategory by name
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [string]
        $subcategoryName,

        # External number
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [ValidateLength(1, 60)]
        [string]
        $externalNumber,

        # Main incident id, required for creating a partial incident. Must be accessable, open, unarchived second line incident.
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $mainIncident,

        # duration by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $duration,

        # Target Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [datetime]
        $targetDate,

        # sla by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $sla,

        # On hold. On hold date will be filled accordingly
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [bool]
        $onHold,

        # operator by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operator,

        # operatorGroup by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operatorGroup,

        # supplier by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $supplier,

        # processingStatus by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $processingStatus,

        # Whether the incident is responded
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [bool]
        $responded,

        # responseDate
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [datetime]
        $responseDate,

        # Whether the incident is completed
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [bool]
        $completed,

        # Completed Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [datetime]
        $completedDate,

        # Closure Code by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $closureCode,

        # Costs
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [float]
        $costs,

        # Rate incident, only available for closed incidents
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidateSet(1, 2, 3, 4, 5)]
        [int]
        $feedbackRating,

        # Leave feedback message on incident, only available for closed incidents and when feedbackRating is given
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [string]
        $feedbackMessage,

        # Major call by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $majorCallObject,

        # Free fields Tab 1
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [hashtable]
        $optionalFields1,

        # Free fields Tab 2
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [hashtable]
        $optionalFields2,

        # Link to an external system - Identifier as supplied by the external system
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $externalLinkID,

        # Link to an external system - Integer to identify the external system by
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [int]
        $externalLinkType,

        # Date of the last synchronization
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [datetime]
        $externalLinkDate

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))

        }

        if (($PSBoundParameters.ContainsKey('externalLinkID')) -and (!($PSBoundParameters.ContainsKey('externalLinkType')))) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("externalLinkType must be provided when using externalLinkID", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
        
    }

    process {

        [PSCustomObject] $newIncident = @{
            'status' = 'partial'
        }

        if($PSBoundParameters.Keys.Count -gt 1) {
            foreach ($item in $PSBoundParameters.GetEnumerator()) {
                switch ($item) {

                    'briefDescription' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'briefDescription' -Value $briefDescription
                        break
                    }

                    'request' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'request' -Value $request
                        break
                    }

                    'action' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'action' -Value $action
                        break
                    }

                    'actionInvisibleForCaller' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'actionInvisibleForCaller' -Value $actionInvisibleForCaller
                        break
                    }

                    'entryType' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value $entryType
                        break
                    }

                    'categoryName' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'name' = $categoryName }
                        break
                    }

                    'categoryID' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'id' = $categoryID } -Force
                        break
                    }

                    'subcategoryName' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'name' = $subcategoryName }
                        break
                    }

                    'subcategoryID' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'id' = $subcategoryID } -Force
                        break
                    }

                    'externalNumber' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalNumber' -Value $externalNumber
                        break
                    }

                    'mainIncident' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'mainIncident ' -Value $mainIncident
                        break
                    }

                    'duration' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'duration' -Value $duration
                        break
                    }

                    'targetDate' {
                        [string] $_newTargetDate = ($targetDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'targetDate' -Value $_newTargetDate
                        break
                    }

                    'sla' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'sla' -Value $sla
                        break
                    }

                    'onHold' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'onHold' -Value $onHold
                        break
                    }

                    'operator' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operator' -Value @{ 'id' = $operator }
                        break
                    }

                    'operatorGroup' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operatorGroup' -Value @{ 'id' = $operatorGroup }
                        break
                    }

                    'supplier' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'supplier' -Value @{ 'id' = $supplier }
                        break
                    }

                    'processingStatus' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'processingStatus' -Value @{ 'id' = $processingStatus }
                        break
                    }

                    'responded' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responded' -Value $responded
                        break
                    }

                    'responseDate' {
                        $_newResponseDate = ($responseDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responseDate' -Value $_newResponseDate
                        break
                    }

                    'completed' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completed' -Value $completed
                        break
                    }

                    'completedDate' {
                        $_newCompletedDate = ($completedDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completedDate' -Value $_newCompletedDate
                        break
                    }

                    'closureCode' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closureCode' -Value $closureCode
                        break
                    }

                    'costs' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'costs' -Value $costs
                        break
                    }

                    'feedbackRating' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackRating' -Value $feedbackRating
                        break
                    }

                    'feedbackMessage' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackMessage' -Value $feedbackMessage
                        break
                    }

                    'majorCallObject' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'majorCallObject' -Value $majorCallObject
                        break
                    }

                    'optionalFields1' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $optionalFields1
                        break
                    }

                    'optionalFields2' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields2' -Value $optionalFields2
                        break
                    }

                    'externalLinkID' {
                        if($PSBoundParameters.ContainsKey('externalLinkType')) {
                            if($PSBoundParameters.ContainsKey('externalLinkDate')) {
                                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType; 'date' = $externalLinkDate }
                            } else {
                                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType }
                            }
                        }
                        break
                    }

                    Default {}
                }
            }
        }

        $_headerslist = @{ 'Content-Type' = 'application/json' }
        $_uri = $script:tdURI + '/tas/api/incidents/'
        $_body = (ConvertTo-Json -InputObject $newIncident -Depth 8 -Compress)

        if($PSCmdlet.ShouldProcess) {
            Get-APIResponse -Method 'POST' -APIurl $_uri -Body $_body -Headers $_headerslist -tdCredential $script:tdCredential
        }

<#         if($PSBoundParameters.ContainsKey('BranchID')) {

            $null = $callerlist.Add([PSCustomObject]@{
                'caller' = @{'branch'=$branchID}
            })
            $callerSet = $true
        }

        if($PSBoundParameters.ContainsKey('phoneNumber')) {
            if($callerSet) {
                $null = $callerList.caller.Add('phoneNumber',$phoneNumber)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'phoneNumber'=$phoneNumber}
                })
                $callerSet = $true
            }
        }

        if($PSBoundParameters.ContainsKey('mobileNumber')) {
            if($callerSet) {
                $null = $callerList.caller.Add('mobileNumber',$mobileNumber)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'mobileNumber'=$mobileNumber}
                })
                $callerSet = $true
            }
        }

        if($PSBoundParameters.ContainsKey('email')) {
            if($callerSet) {
                $null = $callerList.caller.Add('email',$email)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'email'=$email}
                })
                $callerSet = $true
            }
        }

        if($PSBoundParameters.ContainsKey('departmentID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('department',$departmentID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'department'=$departmentID}
                })
                $callerSet = $true
            }
        }
        
        if($PSBoundParameters.ContainsKey('locationID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('location',$locationID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'location'=$locationID}
                })
                $callerSet = $true
            }
        }

        if($PSBoundParameters.ContainsKey('budgetHolderID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('budgetHolder',$budgetHolderID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'budgetHolder'=$budgetHolderID}
                })
                $callerSet = $true
            }
        }

        if($PSBoundParameters.ContainsKey('personExtraFieldAID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldA',$personExtraFieldAID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'personExtraFieldA'=$personExtraFieldAID}
                })
                $callerSet = $true
            }
        }

        if($PSBoundParameters.ContainsKey('personExtraFieldBID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldB',$personExtraFieldBID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'personExtraFieldB'=$personExtraFieldBID}
                })
                $callerSet = $true
            }
        }

        if($callerSet) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'caller' -Value $callerList.caller
        }

        if($PSBoundParameters.ContainsKey('status')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'status' -Value $status
        }

        if($PSBoundParameters.ContainsKey('briefDescription')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'briefDescription' -Value $briefDescription
        }

        if($PSBoundParameters.ContainsKey('request')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'request' -Value $request
        }

        if($PSBoundParameters.ContainsKey('action')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'action' -Value $action
        }

        if($PSBoundParameters.ContainsKey('actionInvisibleForCaller')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'actionInvisibleForCaller' -Value $actionInvisibleForCaller
        }

        if($PSBoundParameters.ContainsKey('entryTypeID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value $entryTypeID
        }

        if($PSBoundParameters.ContainsKey('callTypeID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callType' -Value $callTypeID
        }

        if($PSBoundParameters.ContainsKey('categoryName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'name' = $categoryName }
        }

        if($PSBoundParameters.ContainsKey('categoryID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'id' = $categoryID } -Force
        }

        if($PSBoundParameters.ContainsKey('subcategoryName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'name' = $subcategoryName }
        }

        if($PSBoundParameters.ContainsKey('subcategoryID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'id' = $subcategoryID } -Force
        }

        if($PSBoundParameters.ContainsKey('externalNumber')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalNumber' -Value $externalNumber
        }

        if($PSBoundParameters.ContainsKey('mainIncidentID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'mainIncident' -Value @{ 'id' = $mainIncidentID }
        }

        if($PSBoundParameters.ContainsKey('objectName')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring objectName parameter, this cannot be set for partial incidents"
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'name' = $objectName }
            }
        }

        if($PSBoundParameters.ContainsKey('objectID')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring objectID parameter, this cannot be set for partial incidents"
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID } -Force
            }
        }

        if($PSBoundParameters.ContainsKey('objectLocationID')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring objectID parameter, this cannot be set for partial incidents"
            } elseif(($PSBoundParameters.ContainsKey('objectName')) -or ($PSBoundParameters.ContainsKey('objectID'))) {
                Write-Warning -Message "Ignoring objectLocationID parameter, objectID or objectName provided and superseed this parameter"
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID }
            }
        }

        if($PSBoundParameters.ContainsKey('impactID')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring impactID parameter, this cannot be set for partial incidents. Impact will inherit from Major."
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'impact' -Value $impactID
            }
        }

        if($PSBoundParameters.ContainsKey('urgencyID')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring urgencyID parameter, this cannot be set for partial incidents. urgency will inherit from Major."
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'urgency' -Value $urgencyID
            }
        }

        if($PSBoundParameters.ContainsKey('priorityID')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring priorityID parameter, this cannot be set for partial incidents. priority will inherit from Major."
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'priority' -Value $priorityID
            }
        }

        if($PSBoundParameters.ContainsKey('durationID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'duration' -Value $durationID
        }

        if($PSBoundParameters.ContainsKey('targetDate')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'targetDate' -Value $targetDate
        }

        if($PSBoundParameters.ContainsKey('slaID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'sla' -Value $slaID
        }

        if($PSBoundParameters.ContainsKey('onHold')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'onHold' -Value $onHold
        }

        if($PSBoundParameters.ContainsKey('operatorID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operator' -Value @{ 'id' = $operatorID }
        }

        if($PSBoundParameters.ContainsKey('operatorgroupID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operatorGroup' -Value @{ 'id' = $operatorGroupID }
        }

        if($PSBoundParameters.ContainsKey('supplierID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'supplier' -Value @{ 'id' = $supplierID }
        }

        if($PSBoundParameters.ContainsKey('processingStatusID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'processingStatus' -Value @{ 'id' = $processingStatusID }
        }

        if($PSBoundParameters.ContainsKey('responded')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responded' -Value $responded
        }

        if($PSBoundParameters.ContainsKey('responseDate')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responseDate' -Value $responseDate
        }

        if($PSBoundParameters.ContainsKey('completed')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completed' -Value $completed
        }

        if($PSBoundParameters.ContainsKey('completedDate')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completedDate' -Value $completedDate
        }

        if($PSBoundParameters.ContainsKey('closed')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring closed parameter, this cannot be set for partial incidents. Use completed parameter."
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closed' -Value $closed
            }
        }

        if($PSBoundParameters.ContainsKey('closedDate')) {
            if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                Write-Warning -Message "Ignoring closedDate parameter, this cannot be set for partial incidents. Use completedDate parameter."
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closedDate' -Value $closedDate
            }
        }

        if($PSBoundParameters.ContainsKey('closureCodeID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closureCode' -Value $closureCodeID
        }

        if($PSBoundParameters.ContainsKey('costs')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'costs' -Value $costs
        }

        if($PSBoundParameters.ContainsKey('feedbackRating')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackRating' -Value $feedbackRating
        }

        if($PSBoundParameters.ContainsKey('feedbackMessage')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackMessage' -Value $feedbackMessage
        }

        if($PSBoundParameters.ContainsKey('majorCallObjectID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'majorCallObject' -Value @{ 'id' = $majorCallObjectID}
        }

        if($PSBoundParameters.ContainsKey('freeFields1')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $freeFields1
        }

        if($PSBoundParameters.ContainsKey('freeFields2')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $freeFields2
        }

        if(($PSBoundParameters.ContainsKey('externalLinkID')) -and ($PSBoundParameters.ContainsKey('externalLinkType'))) {
            if($PSBoundParameters.ContainsKey('externalLinkDate')) {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType; 'date' = $externalLinkDate }
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType }
            }
        } #>

    }

    end {

    }
}
