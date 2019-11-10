function Get-OperatorGroup {
    <#
    .Synopsis

      Get a list of operator groups.

    .DESCRIPTION

      Get a list of operator group name and Ids.

    .EXAMPLE

      Get-OperatorGroup

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      The .NET Framework type of the objects that the cmdlet returns.
      You can also include a description of the returned objects.

    .NOTES

      Additional information about the function or script.

    .LINK

      https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-OperatorGroup.md
  #>
    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-OperatorGroup.md",
        ConfirmImpact = 'Medium')]
    [OutputType([String], ParameterSetName = "Default")]
    Param( )
    begin {
        if (!($script:tdConnected)) {
            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))
        }
    }
    process {
        $_uri = $script:tdURI + '/tas/api/operatorgroups/lookup'

        if ($PSBoundParameters.ContainsKey('Archived')) {
            $_uri += '?archived=$true'
        }
        else {
            $_uri += '?&archived=$false'
        }

        $_headerslist = @{
            'Content-Type' = 'application/json'
        }
        Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential
    }
    end {

    }
}
