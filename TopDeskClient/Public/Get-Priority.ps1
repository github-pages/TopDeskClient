function Get-Priority {
  <#
    .Synopsis

      Get list of incident priorities

    .DESCRIPTION

      This command will return the list of priorities name, id and 1st/2nd line duration.

    .EXAMPLE

      Get-Priority

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include id, name, firstLineDuration and secondLineDuration

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfPriorities
  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Priority.md",
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

    $_uri = $script:tdURI + '/tas/api/incidents/priorities'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }

  end { }
    
}
