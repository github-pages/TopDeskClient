---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version:
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

### [PSCustomObject] {
###   id  string($uuid)
###   name  string
###   externalLinks	[
###     id*	string
###     The id of the entity in the external system
###     Size range: maximum 450 characters
###     type*	string
###     The type of the link
###     Range: A non-zero integer formatted as string. Each integration should use its own value. If multiple integrations use the same value, records could be shared between the integrations
###     date	string(datetime)
###     The date of the synchronization
###   ]
### }
## NOTES
None.

## RELATED LINKS

[[/budgetholders](https://developers.topdesk.com/explorer/?page=supporting-files#/Budget%20holders/getBudgetHolders)]()

