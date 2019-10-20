function Get-CallType {
  <#
    .Synopsis

      Get list of Call Types

    .DESCRIPTION

      This command will return the list of call types name and ID.

    .EXAMPLE

      Get-CallType

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include id and name of each call type

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfCallTypes
  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-CallType.md",
    ConfirmImpact = 'Medium')]
  [OutputType([PSCustomObject], ParameterSetName = "Default")]
  Param ()

  begin {
    if (!($script:tdConnected)) {

      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))
    
    }
  
    $_headerslist = @{

      'Content-Type' = 'application/json'

    }

  }

  process {

    $_uri = $script:tdURI + '/tas/api/incidents/call_types'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential
      
  }

  end { }
}
