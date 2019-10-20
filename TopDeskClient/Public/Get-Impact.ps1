function Get-Impact {
  <#
    .Synopsis

      Get list of incident impacts

    .DESCRIPTION

      This command will return the list of impacts name and id.

    .EXAMPLE

      Get-Impact

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include id and name of each impact

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfImpacts
  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Impact.md",
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

    $_uri = $script:tdURI + '/tas/api/incidents/impacts'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }
    
  end { }
  
}
