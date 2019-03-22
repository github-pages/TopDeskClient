---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version:
schema: 2.0.0
---

# Enable-Asset

## SYNOPSIS

Enable a TopDesk asset.

## SYNTAX

``` Powershell
Enable-Asset -AssetID <String> [-Impact] [<CommonParameters>]
```

## DESCRIPTION

This command can be used to enable a TopDesk asset, by default this will unarchive an archived asset. If an active asset is Impacted, pass the -impact switch to enable the asset, changing it's status to Operational.

## EXAMPLES

### EXAMPLE 1

The following command will enable archived asset with id 2131415,  by unarchiving the asset.

``` Powershell
Enable-Asset -AssetID '2131415'
```

### EXAMPLE 2

The following command will enable active but impacted asset with id 8910111, modifying it's status to Operational.

``` Powershell
Enable-Asset -AssetID '8910111' -Impact
```

## PARAMETERS

### -AssetID

ID of the asset to enable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Impact

Change status from IMPACTED to OPERATIONAL

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters [http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [System.Management.Automation.PSCustomObject]

### This command will accept pipeline objects with an AssetID [string] property and optionally an Impacted [switch] property

## OUTPUTS

### [System.Management.Automation.PSCustomObject]

### You can also include a description of the returned objects.

## NOTES

Additional information about the function or script.

## RELATED LINKS

[https://github.com/rbury/TopDeskClient/Docs/Enable-Asset.md](https://github.com/rbury/TopDeskClient/Docs/Enable-Asset.md)
