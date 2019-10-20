function Get-SubCategory {
  <#
    .Synopsis

      Get list of incident subcategories

    .DESCRIPTION

      This command will return the list of subcategories name and id.

    .EXAMPLE

      Get-SubCategory

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include id and name of each category

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfSubcategories
  #>
  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-SubCategory.md",
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

    $_uri = $script:tdURI + '/tas/api/incidents/subcategories'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }

  end { }

}
