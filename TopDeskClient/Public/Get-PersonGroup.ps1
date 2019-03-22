function Get-PersonGroup {
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

        [Get-BlankAsset](https://github.com/rbury/TopDeskClient/Docs/Get-BlankAsset.md)

  #>
    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-BlankAsset.md',
        ConfirmImpact = 'Medium')]
    [OutputType([PSObject])]

    Param (

        # ID of person group to retrieve details for
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Details',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('ID')]
        [string[]]
        $GroupID,

        # Get list of person groups
        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [switch]
        $List

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
    }

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'List' {

                $_uri = $script:tdURI + '/tas/api/persongroups/lookup?$all=true'
                Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

            }

            'Details' {

                foreach ($_persongroup in $GroupID) {

                    $_uri = $script:tdURI + '/tas/api/persongroups/id/' + $_persongroup
                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

                }
            }
        }
    }

    end {}
}