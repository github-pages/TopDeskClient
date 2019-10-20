function Get-ProcessingStatus {
  <#
    .Synopsis

      Get list of processing statuses

    .DESCRIPTION

      This command will return the list of processing statuses name, id, onHold, processingState, response and default.

    .EXAMPLE

      Get-ProcessingStatus

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include name, id, onHold, processingStatus, response and default

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfStatuses
  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-ProcessingStatus.md",
    ConfirmImpact = 'Medium')]
  [OutputType([String], ParameterSetName = "Default")]
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

    $_uri = $script:tdURI + '/tas/api/incidents/statuses'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }

  end { }
}
