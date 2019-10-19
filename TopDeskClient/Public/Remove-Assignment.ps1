function Remove-Assignment {
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

        https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Assignment.md

  #>
  [CmdletBinding(DefaultParameterSetName = 'Confirm',
    SupportsShouldProcess = $true,
    PositionalBinding = $false,
    HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Remove-Assignment.md',
    ConfirmImpact = 'High')]
  [OutputType([string])]

  Param (

    # ID of the Asset
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Confirm',
      ValueFromPipelineByPropertyName = $true)]
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Force',
      ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [Alias('unid')]
    [string]
    $AssetID,

    # ID of the Link
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Confirm',
      ValueFromPipeline = $false,
      ValueFromRemainingArguments = $false,
      ValueFromPipelineByPropertyName = $true)]
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Force',
      ValueFromPipeline = $false,
      ValueFromRemainingArguments = $false,
      ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [Alias('id')]
    [string]
    $LinkID,

    # Force removal without prompting
    [Parameter(Mandatory = $true,
      ParameterSetName = 'Force')]
    [switch]
    $Force
  )

  begin {

    if (!($script:tdConnected)) {

      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

    }
  }

  process {

    if ($PSBoundParameters.ContainsKey('Force') -or ($PSCmdlet.ShouldProcess('Remove Asset Assignment', 'Remove this assignment from the Asset?', "Remove assignment id $LinkID from asset id $AssetID"))) {

      $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/' + $AssetID + '/assignments/' + $LinkID
      Get-APIResponse -Method 'DELETE' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json' } -tdCredential $script:tdCredential

    }
  }

  end { }
}