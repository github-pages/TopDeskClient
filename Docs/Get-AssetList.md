---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Get-ASsetList.md
schema: 2.0.0
---

# Get-AssetList

## SYNOPSIS

Retrieve a list of assets from TopDesk

## SYNTAX

``` Powershell
Get-AssetList -TemplateID <String> [-Fields <String[]>] [-Archive] [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Example of how to use this cmdlet
```

## PARAMETERS

### -TemplateID

Template ID of type of asset to retrieve

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

### -Fields

List of fields to include for each asset

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Archive

Include archved assets?

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

[Get-Asset](https://github.com/rbury/TopDeskClient/blob/master/docs/Get-AssetList.md)
