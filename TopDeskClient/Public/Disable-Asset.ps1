function Disable-Asset {
    <#
    .Synopsis

        Disables asset in TopDesk

    .DESCRIPTION

        Disable-Asset is used to disable an asset in TopDesk. This function provides two levels of disabling the asset (Archive/Impact) and defaults to archiving the asset.

    .PARAMETER AssetID

        AssetID of the asset to manipulate in TopDesk.

    .PARAMETER Archive

        Archive the asset in TopDesk. When archiving an asset you must also provide a reason as defined in the TopDesk instance. To retrieve a list of possible reasons and their corrisponding IDs, use Get-ArchiveReason.

    .PARAMETER ReasonID

        When archiving an asset you must also provide a reason as defined in the TopDesk instance. To retrieve a list of possible reasons and their corrisponding IDs, use Get-ArchiveReason.

     .PARAMETER Impact

        Change the asset status to IMPACTED in TopDesk.

    .EXAMPLE

        Disable-Asset -AssetID 1234567 -Archive -ReasonID 123456789 -Force

        This command will archive the asset with ID 1234567 in TopDesk, set the reason ID to 123456789 and return a PSObject with asset information. Using -Force supresses the request for confirmation to disable the asset.

    .EXAMPLE

        Disable-Asset -AssetID 1234567 -Impact -Force

        This command will set the status to IMPACTED of asset with ID 1234567 in TopDesk, and return a PSObject with asset information. Using -Force supresses the request for confirmation to disable the asset.

    .INPUTS

        This command does not accept input.

    .OUTPUTS

        [PSObject]
        This command will return a [PSObject] representing the modified asset. Properties include settings, metadata, data, fields and functionalities - data will contain the asset field/value pairs.

    .NOTES

        If the attempt to disable the asset fails, the return object will contain the error (for example, when lacking the permission in TopDesk to make this change).

    .LINK

        https://github.com/rbury/TopDeskClient/Docs/Disable-Asset.md

    .LINK

        https://github.com/rbury/TopDeskClient/Docs/Enable-Asset.md

#>

    [CmdletBinding(DefaultParameterSetName = 'Disable',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Disable-Asset.md',
        ConfirmImpact = 'High')]
    [OutputType([PSObject])]

    Param
    (
        # ID of the asset to disable
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('id', 'unid')]
        [string]
        $AssetID,

        # Archive the asset?
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Disable')]
        [switch]
        $Archive,

        # Reason ID identifying archive reason
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Disable')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ReasonID,

        # Change asset status to impacted?
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Impact')]
        [switch]
        $Impact,

        # Suppress confirmation prompt?
        [Parameter(Mandatory = $false)]
        [switch]
        $Force
    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
    }

    process {

        switch ($pscmdlet.ParameterSetName) {

            'Disable' {

                if ($PSBoundParameters.ContainsKey('Force') -or ($PSCmdlet.ShouldProcess("Archive asset with id: $AssetID", 'Archive this Asset?', 'Archive asset'))) {

                    $_uri = $Script:tdURI + '/tas/api/assetmgmt/assets/' + $AssetID + '/archive'
                    $_body = ConvertTo-Json -InputObject (@{'reasonId' = $ReasonID})
                    $_headerslist = @{'Content-Type' = 'application/json'}

                    Get-APIResponse -Method 'POST' -APIUrl $_uri -body $_body -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break

            }

            'Impact' {

                if ($PSBoundParameters.ContainsKey('Force') -or ($PSCmdlet.ShouldProcess("Set status of asset id $AssetID to Impacted", 'Impact this Asset?', 'Impact asset'))) {

                    $_uri = $Script:tdURI + '/tas/api/assetmgmt/assets/' + $AssetID
                    $_body = ConvertTo-Json -InputObject (@{'@status' = 'IMPACTED'})
                    $_headerslist = @{'Content-Type' = 'application/json'}

                    Get-APIResponse -Method 'POST' -APIUrl $_uri -body $_body -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break

            }
        }
    }

    end {}

}