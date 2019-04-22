---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Remove-Assignment.md
schema: 2.0.0
---

# Remove-Assignment

## SYNOPSIS

Remove existing assignemnts from assets in TopDesk

## SYNTAX

### Confirm (Default)

``` Powershell
Remove-Assignment -AssetID <String> -LinkID <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Force

``` Powershell
Remove-Assignment -AssetID <String> -LinkID <String> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Example of how to use this cmdlet
```

## PARAMETERS

### -AssetID

ID of the Asset

```yaml
Type: String
Parameter Sets: (All)
Aliases: unid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LinkID

ID of the Link

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Force removal without prompting

```yaml
Type: SwitchParameter
Parameter Sets: Force
Aliases:

Required: True
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

The Microsoft .NET Framework types of objects that can be piped to the function or script.
You can also include a description of the input objects.

## OUTPUTS

The .NET Framework type of the objects that the cmdlet returns.
You can also include a description of the returned objects.

## NOTES

Additional information about the function or script.

## RELATED LINKS

[Remove-Assignment](https://github.com/rbury/TopDeskClient/blob/master/docs/Remove-Assignment.md)
