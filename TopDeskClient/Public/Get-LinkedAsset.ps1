function Get-LinkedAsset {
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

        https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md

  #>
  [CmdletBinding(DefaultParameterSetName = 'Type',
    PositionalBinding = $false,
    HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-LinkedAsset.md',
    ConfirmImpact = 'Medium')]
  [OutputType([PSobject])]

  Param (

    # Type of item linked (incident, person, persongroup, branch, location)
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Type',
      ValueFromPipelineByPropertyName = $true)]
    [ValidateSet('incident', 'person', 'persongroup', 'branch', 'location')]
    [string]
    $Type,

    # Id of linked item
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Type',
      ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $ID,

    # Fields to retrieve
    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true)]
    [ValidateCount(0, 500)]
    [Alias('fields')]
    [string[]]
    $AssetFields,

    # Exclude Assignments?
    [Parameter(Mandatory = $false)]
    [switch]
    $NoAssignments
  )

  begin {

    if (!($script:tdConnected)) {

      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

    }
  }

  process {

    if ($PSBoundParameters.ContainsKey("AssetFields")) {

      $_fieldlist = [string]::Join(",", $AssetFields)

    }
    else {

      $_fieldlist = ''

    }

    if ($_fieldlist -ne '') {

      $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?$filter=linkedTo eq ' + "$Type/$ID" + '&fields=' + $_fieldList

    }
    else {

      $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?$filter=linkedTo eq ' + "$Type/$ID" + '&fields=name'

    }

    if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

      $_uri += '&showAssignments=$true'

    }

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json' } -tdCredential $script:tdCredential

  }

  end { }
    
}