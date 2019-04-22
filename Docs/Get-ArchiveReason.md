---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Get-ArchiveReason.md
schema: 2.0.0
---

# Get-ArchiveReason

## SYNOPSIS

Retrieve a list of archive reasons

## SYNTAX

### Default (Default)

``` Powershell
Get-ArchiveReason [-All] [<CommonParameters>]
```

### ByName

``` Powershell
Get-ArchiveReason -ReasonName <String> [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Get-ArchiveReason
```

This example gets the list of all archive reasons and their corrisponding IDs.

## PARAMETERS

### -All

Get all resons and ids

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReasonName

Archive reason name (returns matching id)

```yaml
Type: String
Parameter Sets: ByName
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

### None

The Microsoft .NET Framework types of objects that can be piped to the function or script.
You can also include a description of the input objects.

## OUTPUTS

### Output - PSCustomObject

[PSCustomObject]

## NOTES

Additional information about the function or script.

## RELATED LINKS

[Get-ArchiveReason](https://github.com/rbury/TopDeskClient/Docs/Get-ArchiveReason.md)
