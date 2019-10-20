---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md
schema: 2.0.0
---

# Get-BlankAsset

## SYNOPSIS

Short description

## SYNTAX

### Default (Default)

``` Powershell
Get-BlankAsset -TemplateName <String> [<CommonParameters>]
```

### ByID

``` Powershell
Get-BlankAsset -TemplateID <String> [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Get-BlankAsset -TemplateName 'Computer'
```

## PARAMETERS

### -TemplateID

Asset template id

``` yaml
Type: String
Parameter Sets: ByID
Aliases: ID

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TemplateName

Asset template name (case sensitive)

``` yaml
Type: String
Parameter Sets: Default
Aliases: Name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

The Microsoft . NET Framework types of objects that can be piped to the function or script.
You can also include a description of the input objects.

## OUTPUTS

The . NET Framework type of the objects that the cmdlet returns.
You can also include a description of the returned objects.

## NOTES

None.

## RELATED LINKS

[Get-Asset](https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md)

