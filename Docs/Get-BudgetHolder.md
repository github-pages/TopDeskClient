---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://developers.topdesk.com/explorer/?page=supporting-files#/Budget%20holders/getBudgetHolders
schema: 2.0.0
---

# Get-BudgetHolder

## SYNOPSIS
Get list of budget holders

## SYNTAX

### Default (Default)
```
Get-BudgetHolder [<CommonParameters>]
```

### ByLink
```
Get-BudgetHolder -external_link_id <String[]> -external_link_type <String[]> [<CommonParameters>]
```

## DESCRIPTION
This command will return the list of budget holders names and ID.

## EXAMPLES

### EXAMPLE 1
```
Get-BudgetHolder
```

## PARAMETERS

### -external_link_id
Retrieve only budget holders with external link id equal to one of these values

```yaml
Type: String[]
Parameter Sets: ByLink
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -external_link_type
Retrieve only budget holders with external link type equal to one of these values

```yaml
Type: String[]
Parameter Sets: ByLink
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

### None.
## OUTPUTS

### [PSCustomObject] - Properties include id (string), name (string), externalLinks (array) - id (string id from external system) : type (string type of link) : date (string datetime of synchronization)
## NOTES
None.

## RELATED LINKS

[https://developers.topdesk.com/explorer/?page=supporting-files#/Budget%20holders/getBudgetHolders](https://developers.topdesk.com/explorer/?page=supporting-files#/Budget%20holders/getBudgetHolders)

