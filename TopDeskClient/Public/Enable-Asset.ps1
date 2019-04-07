function Enable-Asset {
    <#
    .Synopsis

        Enable a TopDesk asset.

    .DESCRIPTION

        This command can be used to enable a TopDesk asset, the behaviour of enabling an asset is determined by the current status of an asset. Assets that are currently archived will be unarchived, active assets that are impacted will be changed to operational.

    .PARAMETER AssetID

        ID of the asset to enable

    .EXAMPLE

        The following command will enable asset with id 2131415.
      
        Enable-Asset -AssetID '2131415'

    .EXAMPLE

        The following command retrieves the asset from TopDesk with asset name 123YYY7 and enables the asset.

        (Get-Asset -name '123YYY7').dataSet | Enable-Asset

    .INPUTS

        [System.Management.Automation.PSCustomObject]

        This command will accept pipeline objects with an AssetID [string] property.
        When retrieving assets from TopDesk using Get-Asset, pass the returned dataSet property (see examples).

    .OUTPUTS

      [System.Management.Automation.PSCustomObject]
      
      PSObject will represent modified asset including the following properties: settings, metadata, data, fields, functionalities.

    .LINK

        [Enable-Asset](https://github.com/rbury/TopDeskClient/Docs/Enable-Asset.md)

    .LINK
        [Disable-Asset](https://github.com/rbury/TopDeskClient/Docs/Disable-Asset.md)

    .LINK
        [Get-Asset](https://github.com/rbury/TopDeskClient/Docs/Get-Asset.md)

  #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $true,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Enable-Asset.md',
        ConfirmImpact = 'Medium')]
    [OutputType([PSObject])]

    Param
    (

        # ID of the asset to enable
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            Position=0)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [Alias('unid')]
        [string]
        $AssetID

    )
    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_headerslist = @{'Content-Type' = 'application/json'}
        
    }

    process {
        
        try {

            $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/' + $AssetID
            $_status = Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

            if($_status.data.archived) {
                
               $_uri = $Script:tdURI + '/tas/api/assetmgmt/assets/' + $AssetID + '/unarchive'

               $result = Get-APIResponse -Method 'POST' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

            }
        }
        catch {
        
            Write-Error ("Problem unarchiving asset {0}" -f $_.Exception.Message)

        }

        try {

            if ($_status.data.'@status' -eq 'IMPACTED') {

                $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/' + $AssetID
                $_body = @{
                    '@status' = "OPERATIONAL"
                }
    
                $_body = ConvertTo-Json -InputObject $_body
    
                $result = Get-APIResponse -Method 'POST' -APIUrl $_uri -body $_body -Headers $_headerslist -tdCredential $script:tdCredential

            }
        }
        catch {
        
                Write-Error ("Problem unarchiving asset {0}" -f $_.Exception.Message)
    
        }

        return $result
    }

    end {}

}
