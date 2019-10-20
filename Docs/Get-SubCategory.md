---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://developers.topdesk.com/documentation/index.html#api-General-GetListOfSubcategories
schema: 2.0.0
---

# Get-SubCategory

## SYNOPSIS

Get list of incident subcategories

## SYNTAX

``` Powershell
Get-SubCategory [<CommonParameters>]
```

## DESCRIPTION

This command will return the list of subcategories name, id and category.

## EXAMPLES

### EXAMPLE 1

``` Powershell
Get-SubCategory
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None.

## OUTPUTS

[PSCustomObject]
Properties include id and name of each subcategory and the parent category it belongs to

## NOTES

None.

## RELATED LINKS

[TopDeskAPI - GetListOfSubcategories](https://developers.topdesk.com/documentation/index.html#api-General-GetListOfSubcategories)

