function New-BasicIncident {
    <#
    .Synopsis

      Create a new incident.

    .DESCRIPTION

      This cmdlet provides the ability to create an incidnet with a subset of the most common options.

    .EXAMPLE

      New-Incidnet -status 'firstLine' -briefDescription 'My firstLine Issue' -request 'This is my first incident' -category 'Hardware' -subcategory 'Printer'

      Crate a new first line incident under category Hardware > Printer with a breif description and initial request.

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      [PSCustomObject]

    .NOTES

      This function only exposes a subset of options available for incidents. If you require more options when creating a new incident, use New-Incident.

    .LINK

      https://github.com/rbury/TopDeskClient/blob/master/Docs/New-Incident.md
  #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/New-BasicIncident.md",
        ConfirmImpact = 'Medium')]
    [OutputType([PSCustomObject], ParameterSetName = "Default")]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Type of caller lookup (id, email, employeenumber, networkLoginName, loginName')]
        [ValidateSet('id', 'email', 'employeenumber', 'networkLoginName', 'loginName')]
        [string]
        $CallerType,

        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Value to be used with CallerType')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Caller,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Status of the incident (firstLine, secondLine')]
        [ValidateSet('firstLine', 'secondLine')]
        [string]
        $Status = 'firstLine',

        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Value for the briefDescription')]
        [ValidateLength(1, 80)]
        [string]
        $BriefDescription,

        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Value for the initial request')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Request,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of an existing entryType')]
        [string]
        $EntryType,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of an existing callType')]
        [string]
        $CallType,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of an existing category')]
        [string]
        $Category,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of an existing subCategory')]
        [string]
        $SubCategory,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Asset name to link to incident')]
        [string]
        $ObjectName,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of an existing impact')]
        [string]
        $Impact,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of an existing urgency')]
        [string]
        $Urgency,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Incident targetDate')]
        [datetime]
        $TargetDate,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name of operator')]
        [string]
        $Operator,

        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = 'Name ofoperator group')]
        [string]
        $OperatorGroup
    )

    begin {
        if (!($script:tdConnected)) {
            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))
        }
    }
    process {
        $params = @{
            status           = $Status
            briefDescription = $BriefDescription
            request          = $Request
        }

        switch ($CallerType) {
            'id' {
                $null = $params.Add('callerLookupID', $Caller)
                break
            }
            'email' {
                $null = $params.Add('callerLookupEmail', $Caller)
                break
            }
            'employeeNumber' {
                $null = $params.Add('callerLookupEmployeeNumber', $Caller)
                break
            }
            'networkLoginName' {
                $null = $params.Add('callerLookupNetworkLoginName', $Caller)
                break
            }
            'loginName' {
                $null = $params.Add('callerLookupLoginName', $Caller)
                break
            }
        }
        if ($PSBoundParameters.ContainsKey('EntryType')) {
            $params.Add('entryTypeName', $EntryType)
        }
        if ($PSBoundParameters.ContainsKey('CallType')) {
            $params.Add('callTypeName', $CallType)
        }
        if ($PSBoundParameters.ContainsKey('Category')) {
            $params.Add('categoryName', $Category)
        }
        if ($PSBoundParameters.ContainsKey('SubCategory')) {
            $params.Add('subCategoryName', $SubCategory)
        }
        if ($PSBoundParameters.ContainsKey('ObjectName')) {
            $params.Add('objectName', $ObjectName)
        }
        if ($PSBoundParameters.ContainsKey('Impact')) {
            $params.Add('impactName', $Impact)
        }
        if ($PSBoundParameters.ContainsKey('Urgency')) {
            $params.Add('urgencyName', $Urgency)
        }
        if ($PSBoundParameters.ContainsKey('TargetDate')) {
            $params.Add('targetDate', $TargetDate)
        }
        if ($PSBoundParameters.ContainsKey('Operator')) {
            $Operatorobj = (Get-Operator).results | Where-Object {$_.name -ieq $Operator}
            if($null -ne $Operatorobj) {
                $params.Add('operator', $Operatorobj.id)
            }
            else {
                $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("The supplied Operator name was not found in list of operators.", $null, [System.Management.Automation.ErrorCategory]::ObjectNotFound, $null))
            }
        }
        if ($PSBoundParameters.ContainsKey('OperatorGroup')) {
            $OperatorGroupobj = (Get-OperatorGroup).results | Where-Object {$_.name -ieq $OperatorGroup}
            if ($null -ne $OperatorGroupobj) {
                $params.Add('operatorGroupName', $OperatorGroup)
            }
            else {
                $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("The supplied Operator Group name was not found in list of operator groups.", $null, [System.Management.Automation.ErrorCategory]::ObjectNotFound, $null))
            }
        }
        if ($PSCmdlet.ShouldProcess("Incident - $($BriefDescription)", "Create")) {
            New-Incident @params
        }
    }
    end {
    }
}
