---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://developers.topdesk.com/documentation/index.html#api-General-GetListOfImpacts
schema: 2.0.0
---

# Get-Impact

## SYNOPSIS

Get list of incident impacts

## SYNTAX

``` Powershell
Get-Impact [<CommonParameters>]
```

## DESCRIPTION

This command will return the list of impacts name and id.

## EXAMPLES

### EXAMPLE 1

``` Powershell
Get-Impact
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None.

## OUTPUTS

[PSCustomObject]
Properties include id and name of each impact

## NOTES

None.

## RELATED LINKS

[TopDeskAPI - GetListOfImpacts](https://developers.topdesk.com/documentation/index.html#api-General-GetListOfImpacts)

