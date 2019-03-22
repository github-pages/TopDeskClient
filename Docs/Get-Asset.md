---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version:
schema: 2.0.0
---

# Get-Asset

## SYNOPSIS
Short description

## SYNTAX

### AllAssets (Default)
```
Get-Asset -AssetType <String> [-OperationalStatus <String>] [-ActiveOnly] [[-AssetFields] <String[]>]
 [-NoAssignments] [<CommonParameters>]
```

### ArchivedAssets
```
Get-Asset -AssetType <String> [-OperationalStatus <String>] [-ArchivedOnly] [[-AssetFields] <String[]>]
 [-NoAssignments] [<CommonParameters>]
```

### NameSearch
```
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -Name <String> [<CommonParameters>]
```

### FreeText
```
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -SearchString <String> [<CommonParameters>]
```

### LinkSearch
```
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -LinkList <Hashtable> [<CommonParameters>]
```

### Filter
```
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -Filter <String> [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
Example of how to use this cmdlet
```

## PARAMETERS

### -AssetType
Asset type to retrieve

```yaml
Type: String
Parameter Sets: AllAssets, ArchivedAssets
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OperationalStatus
limit to operational status

```yaml
Type: String
Parameter Sets: AllAssets, ArchivedAssets
Aliases: Status

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ActiveOnly
Limit to active only

```yaml
Type: SwitchParameter
Parameter Sets: AllAssets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ArchivedOnly
Limit to archived only

```yaml
Type: SwitchParameter
Parameter Sets: ArchivedAssets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AssetFields
Fields to retrieve

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

### -Name
Search by name

```yaml
Type: String
Parameter Sets: NameSearch
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SearchString
Free text search

```yaml
Type: String
Parameter Sets: FreeText
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LinkList
List of linked ids

```yaml
Type: Hashtable
Parameter Sets: LinkSearch
Aliases: Links

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filter
Filter string (limited simple odata filter)

```yaml
Type: String
Parameter Sets: Filter
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### The Microsoft .NET Framework types of objects that can be piped to the function or script.
### You can also include a description of the input objects.
## OUTPUTS

### The .NET Framework type of the objects that the cmdlet returns.
### You can also include a description of the returned objects.
## NOTES
Additional information about the function or script.

## RELATED LINKS

[The name of a related topic. The value appears on the line below the ".LINK" keyword and must be preceded by a comment symbol # or included in the comment block.
Repeat the ".LINK" keyword for each related topic.]()

