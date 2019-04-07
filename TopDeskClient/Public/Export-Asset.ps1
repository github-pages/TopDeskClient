function Export-Asset {
    <#
    .Synopsis

        Export a list of assets.

    .DESCRIPTION

        Export-Asset can be used to export a list of assets for later consumption, by default this will be a binary export that can be reloaded using Import-Asset. Optionally the asset list can be exported in json or csv format for other purposes.

    .PARAMETER FilePath

        Specifiy the file path to save exported assets in.

    .EXAMPLE

        The following example retrieves the asset with name 'DW3YJM2' from TopDesk with selected fields and exports this asset to c:\temp\myAsset.json.

        (Get-Asset -Name 'DW3YJM2' -AssetFields'name','computer-make','computer-model') | Export-Asset -FilePath c:\temp\myAsset.json -json

    .EXAMPLE

        The following example retrieves all assets from TopDesk containing computer-image-date field with a date greater than 2019-03-19 and less than 2019-13-21 and exports the list to C:\temp\myAssets.csv. Note assets were retrieved without assignments as these additaional objects would require process into properties to useful in a CSV export.

        (Get-Asset -Filter 'computer-image-date gt 2019-03-19 and computer-image-date lt 2019-03-21' -NoAssignments) | Export-Asset -FilePath c:\temp\myAssets.csv -csv

    .INPUTS

        [PSObject]

    .OUTPUTS

        This command does not return any output.

    .LINK

        [Export-Asset](https://github.com/rbury/TopDeskClient/Docs/Export-Asset.md)
      
  #>
    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Export-Asset.md',
        ConfirmImpact = 'Medium')]
    [OutputType([NullString])]

    Param (

        # Path to file
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'Default')]
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'json')]
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'csv')]
        [ValidateNotNullOrEmpty()]
        [Alias('Path', 'File')]
        [string]
        $FilePath,

        # Assets to export
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'Default')]
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'json')]
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'csv')]
        [ValidateNotNullOrEmpty()]
        [Alias('object')]
        [psobject]
        $Assets,

        # Export in json format?
        [Parameter(Mandatory = $false,
            ParameterSetName = 'json')]
        [switch]
        $json,

        # Export in csv format?
        [Parameter(Mandatory = $false,
            ParameterSetName = 'csv')]
        [switch]
        $csv

    )

    begin {

        $_path = Split-Path $FilePath
        $_fileName = Split-Path $FilePath -Leaf

        if(-not(Test-Path -Path $_path -PathType Container)) {
            $null = New-Item -Path $_path -ItemType Container -Force
        }

    }

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'json' {

                ConvertTo-Json -InputObject $Assets -Depth 25 | Out-File -FilePath $FilePath -Encoding utf8 -Append

            }
            'csv' {

                foreach ($item in $Assets.dataSet) {
                    Export-Csv -Path $FilePath -InputObject $item -Append -NoTypeInformation
                }

            }
            Default {

                Export-Object -FilePath $_path -FileName $_fileName -ExportObject $Assets

            }
        }
    }

    end {}

}