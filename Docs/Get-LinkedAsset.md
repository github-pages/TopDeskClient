---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md
schema: 2.0.0
---

# Get-LinkedAsset

## SYNOPSIS
Short description

## SYNTAX

```
Get-LinkedAsset -Type <String> -ID <String> [-AssetFields <String[]>] [-NoAssignments] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
Example of how to use this cmdlet
```

## PARAMETERS

### -Type
Type of item linked (incident, person, persongroup, branch, location)

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

### -ID
Id of linked item

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

### -AssetFields
Fields to retrieve

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: fields

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoAssignments
Exclude Assignments?

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

### The Microsoft .NET Framework types of objects that can be piped to the function or script.
### You can also include a description of the input objects.
## OUTPUTS

### The .NET Framework type of the objects that the cmdlet returns.
### You can also include a description of the returned objects.
## NOTES
Additional information about the function or script.

## RELATED LINKS

[https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md](https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md)

