---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Disable-Asset.md
schema: 2.0.0
---

# Enable-Asset

## SYNOPSIS

Enable a TopDesk asset.

## SYNTAX

``` Powershell
Enable-Asset [-AssetID] <String> [<CommonParameters>]
```

## DESCRIPTION

This command can be used to enable a TopDesk asset, the behaviour of enabling an asset is determined by the current status of an asset.
Assets that are currently archived will be unarchived, active assets that are impacted will be changed to operational.

## EXAMPLES

### EXAMPLE 1

``` Powershell
The following command will enable asset with id 2131415.
```

Enable-Asset -AssetID '2131415'

### EXAMPLE 2

``` Powershell
The following command retrieves the asset from TopDesk with asset name 123YYY7 and enables the asset.
```

(Get-Asset -name '123YYY7').dataSet | Enable-Asset

## PARAMETERS

### -AssetID

ID of the asset to enable

``` yaml
Type: String
Parameter Sets: (All)
Aliases: unid

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

[PSCustomObject]
This command will accept pipeline objects with an AssetID [string] property.
When retrieving assets from TopDesk using Get-Asset, pass the returned dataSet property (see examples).

## OUTPUTS

[PSCustomObject]
PSObject will represent modified asset including the following properties: settings, metadata, data, fields, functionalities.

## NOTES

None.

## RELATED LINKS

[Disable-Asset](https://github.com/rbury/TopDeskClient/blob/master/Docs/Disable-Asset.md)

[https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md](https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md)

