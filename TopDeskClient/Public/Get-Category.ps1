function Get-Category {
  <#
    .Synopsis

      Get list of incident categories

    .DESCRIPTION

      This command wil return the list of categories name and id.

    .EXAMPLE

      Get-Categories

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject]
      Properties include id and name of each category

    .NOTES

      None.

    .LINK
    
      https://developers.topdesk.com/documentation/index.html#api-General-GetListOfCategories

  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Category.md",
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

    $_uri = $script:tdURI + '/tas/api/incidents/categories'

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }
    
  end { }
}
