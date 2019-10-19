function Get-ArchiveReason {
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
      
  #>
  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-ArchiveReason.md',
    ConfirmImpact = 'Medium')]
  [OutputType([PSObject], ParameterSetName = 'Default')]
  [OutputType([string], ParameterSetName = 'ByName')]

  Param (

    # Get all resons and ids
    [Parameter(Mandatory = $false,
      ParameterSetName = 'Default')]
    [switch]
    $All,

    # Archive reason name (returns matching id)
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'ByName')]
    [Alias('Name')]
    [string]
    $ReasonName

  )

  begin {

    if (!($script:tdConnected)) {

      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

    }
  }

  process {

    $_uri = $script:tdURI + '/tas/api/archiving-reasons'

    $_headerslist = @{
      'Content-Type' = 'application/json'
    }

    switch ($PSCmdlet.ParameterSetName) {
      'ByName' {

        ((Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential) | Where-Object { $_.name -eq $ReasonName }).id
        # $_response.name.Where({$_ -eq $ReasonName})
        # $_response.name.Where({$_ -eq $ReasonName}).id

      }
      'Default' {

        Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

      }
    }
  }

  end { }

}