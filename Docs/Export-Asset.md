---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Export-Asset.md
schema: 2.0.0
---

# Export-Asset

## SYNOPSIS

Export a list of assets.

## SYNTAX

### Default (Default)

``` Powershell
Export-Asset -FilePath <String> -Assets <PSObject> [<CommonParameters>]
```

### json

``` Powershell
Export-Asset -FilePath <String> -Assets <PSObject> [-json] [<CommonParameters>]
```

### csv

``` Powershell
Export-Asset -FilePath <String> -Assets <PSObject> [-csv] [<CommonParameters>]
```

## DESCRIPTION

Export-Asset can be used to export a list of assets for later consumption, by default this will be a binary export that can be reloaded using Import-Asset.
Optionally the asset list can be exported in json or csv format for other purposes.

## EXAMPLES

### EXAMPLE 1

``` Powershell
(Get-Asset -Name 'DW3YJM2' -AssetFields'name','computer-make','computer-model') | Export-Asset -FilePath c:\temp\myAsset.json -json
```

This example retrieves the asset with name 'DW3YJM2' from TopDesk with selected fields and exports this asset to c:\temp\myAsset.json.

### EXAMPLE 2

``` Powershell
(Get-Asset -Filter 'computer-image-date gt 2019-03-19 and computer-image-date lt 2019-03-21' -NoAssignments) | Export-Asset -FilePath c:\temp\myAssets.csv -csv
```

This example retrieves all assets from TopDesk containing computer-image-date field with a date greater than 2019-03-19 and less than 2019-13-21 and exports the list to C:\temp\myAssets.csv. Note assets were retrieved without assignments as these additaional objects would require process into properties to useful in a CSV export.

## PARAMETERS

### -FilePath

Specifiy the file path to save exported assets in.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path, File

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Assets

Assets to export

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: object

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -json

Export in json format?

```yaml
Type: SwitchParameter
Parameter Sets: json
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -csv

Export in csv format?

```yaml
Type: SwitchParameter
Parameter Sets: csv
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Input - PSObject

[PSObject]

## OUTPUTS

### None

This command does not return any output.

## NOTES

## RELATED LINKS

[Export-Asset](https://github.com/rbury/TopDeskClient/Docs/Export-Asset.md)
