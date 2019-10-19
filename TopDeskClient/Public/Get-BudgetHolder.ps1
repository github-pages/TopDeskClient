function Get-BudgetHolder {
  <#
    .Synopsis

      Get list of budget holders

    .DESCRIPTION

      This command will return the list of budget holders names and ID.

    .EXAMPLE

      Get-BudgetHolder

    .INPUTS

      None.

    .OUTPUTS

      [PSCustomObject] {

        id  string($uuid)
        name  string

        externalLinks	[
          id*	string
          The id of the entity in the external system
          Size range: maximum 450 characters

          type*	string
          The type of the link
          Range: A non-zero integer formatted as string. Each integration should use its own value. If multiple integrations use the same value, records could be shared between the integrations

          date	string(datetime)
          The date of the synchronization
        ]

      }

    .NOTES

      None.

    .LINK
    
      [/budgetholders](https://developers.topdesk.com/explorer/?page=supporting-files#/Budget%20holders/getBudgetHolders)
  #>
  
  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-BudgetHolder.md",
    ConfirmImpact = 'Medium')]
  [OutputType([PSCustomObject], ParameterSetName = 'Default')]
  [OutputType([PSCustomObject], ParameterSetName = 'ByLink')]
    
  Param(

    # Retrieve only budget holders with external link id equal to one of these values
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'ByLink')]
    [string[]]
    $external_link_id,

    # Retrieve only budget holders with external link type equal to one of these values
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'ByLink')]
    [string[]]
    $external_link_type

  )

  begin {
    if (!($script:tdConnected)) {

      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

    }

    $_headerslist = @{
      'Content-Type' = 'application/json'
    }

  }

  process {

    switch ($PSCmdlet.ParameterSetName) {

      'Default' {

        $_uri = $script:tdURI + '/tas/api/budgetholders'
        break

      }

      'ByLink' {

        $_uri = $script:tdURI + '/tas/api/budgetholders?'

        $_uri += '&external_link_id=' + ($external_link_id -join ",")

        $_uri += '&external_link_type=' + ($external_link_type -join ",")

        break

      }

    }

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

  }

  end { }
}
