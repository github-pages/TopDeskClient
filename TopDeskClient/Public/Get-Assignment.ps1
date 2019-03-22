function Get-Assignment {
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

        [Get-Assignment](https://github.com/rbury/TopDeskClient/Docs/Get-Assignment.md)

  #>
    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-Assignment.md',
        ConfirmImpact = 'Medium')]
    [OutputType([PSObject])]

    Param (

        # ID of asset to retrieve assignments for
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Default',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('ID')]
        [string[]]
        $AssetID

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
    }

    process {

        foreach ($_assetID in $AssetID) {

            $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/' + $_assetID + '/assignments'
            Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

        }
    }

    end {}
}