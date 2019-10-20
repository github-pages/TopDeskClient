---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://developers.topdesk.com/documentation/index.html#api-General-GetListOfPriorities
schema: 2.0.0
---

# Get-Priority

## SYNOPSIS

Get list of incident priorities

## SYNTAX

``` Powershell
Get-Priority [<CommonParameters>]
```

## DESCRIPTION

This command will return the list of priorities name, id and 1st/2nd line duration.

## EXAMPLES

### EXAMPLE 1

``` Powershell
Get-Priority
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None.

## OUTPUTS

[PSCustomObject]
Properties include id, name, firstLineDuration and secondLineDuration

## NOTES

None.

## RELATED LINKS

[TopDeskAPI - GetListOfPriorities](https://developers.topdesk.com/documentation/index.html#api-General-GetListOfPriorities)

