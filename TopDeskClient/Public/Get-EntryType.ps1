function Get-EntryType {
  <#
    .Synopsis

      Get list of incident entry types

    .DESCRIPTION

      This command will return the list of entry types name and id.

    .EXAMPLE

      Get-EntryType

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include id and name of each entry type

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfEntryTypes
  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-EntryType.md",
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

    $_uri = $script:tdURI + '/tas/api/incidents/entry_types'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }
  
  end { }

}
