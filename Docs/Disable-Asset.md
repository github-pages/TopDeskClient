---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Enable-Asset.md
schema: 2.0.0
---

# Disable-Asset

## SYNOPSIS
Disables asset in TopDesk

## SYNTAX

### Disable (Default)
```
Disable-Asset -AssetID <String> [-Archive] -ReasonID <String> [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Impact
```
Disable-Asset -AssetID <String> [-Impact] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disable-Asset is used to disable an asset in TopDesk.
This function provides two levels of disabling the asset (Archive/Impact) and defaults to archiving the asset.

## EXAMPLES

### EXAMPLE 1
```
Disable-Asset -AssetID 1234567 -Archive -ReasonID 123456789 -Force
```

This command will archive the asset with ID 1234567 in TopDesk, set the reason ID to 123456789 and return a PSObject with asset information.
Using -Force supresses the request for confirmation to disable the asset.

### EXAMPLE 2
```
Disable-Asset -AssetID 1234567 -Impact -Force
```

This command will set the status to IMPACTED of asset with ID 1234567 in TopDesk, and return a PSObject with asset information.
Using -Force supresses the request for confirmation to disable the asset.

## PARAMETERS

### -AssetID
AssetID of the asset to manipulate in TopDesk.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id, unid

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archive
Archive the asset in TopDesk.
When archiving an asset you must also provide a reason as defined in the TopDesk instance.
To retrieve a list of possible reasons and their corrisponding IDs, use Get-ArchiveReason.

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReasonID
When archiving an asset you must also provide a reason as defined in the TopDesk instance.
To retrieve a list of possible reasons and their corrisponding IDs, use Get-ArchiveReason.

```yaml
Type: String
Parameter Sets: Disable
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Impact
Change the asset status to IMPACTED in TopDesk.

```yaml
Type: SwitchParameter
Parameter Sets: Impact
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Suppress confirmation prompt?

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### This command does not accept input.
## OUTPUTS

### [PSObject]
### This command will return a [PSObject] representing the modified asset. Properties include settings, metadata, data, fields and functionalities - data will contain the asset field/value pairs.
## NOTES
If the attempt to disable the asset fails, the return object will contain the error (for example, when lacking the permission in TopDesk to make this change).

## RELATED LINKS

[https://github.com/rbury/TopDeskClient/blob/master/Docs/Enable-Asset.md](https://github.com/rbury/TopDeskClient/blob/master/Docs/Enable-Asset.md)

