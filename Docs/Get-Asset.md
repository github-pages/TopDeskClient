---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Get-Asset.md
schema: 2.0.0
---

# Get-Asset

## SYNOPSIS

Retrieve one or more assets from TopDesk

## SYNTAX

### AllAssets (Default)

``` Powershell
Get-Asset -AssetType <String> [-OperationalStatus <String>] [-ActiveOnly] [[-AssetFields] <String[]>]
 [-NoAssignments] [<CommonParameters>]
```

### ArchivedAssets

``` Powershell
Get-Asset -AssetType <String> [-OperationalStatus <String>] [-ArchivedOnly] [[-AssetFields] <String[]>]
 [-NoAssignments] [<CommonParameters>]
```

### NameSearch

``` Powershell
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -Name <String> [<CommonParameters>]
```

### FreeText

``` Powershell
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -SearchString <String> [<CommonParameters>]
```

### LinkSearch

``` Powershell
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -LinkList <Hashtable> [<CommonParameters>]
```

### Filter

``` Powershell
Get-Asset [[-AssetFields] <String[]>] [-NoAssignments] -Filter <String> [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
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
Accept pipeline input: False
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
Accept pipeline input: False
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Input - PSCustomObject

[PSCustomObject]

## OUTPUTS

### Output - PSCustomObject

[PSCustomObject]

## NOTES

Additional information about the function or script.

## RELATED LINKS

[Get-Asset](https://github.com/rbury/TopDeskClient/blob/master/docs/Get-Asset.md)
