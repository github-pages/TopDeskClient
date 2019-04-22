---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Disconnect-TopDesk.md
schema: 2.0.0
---

# Disconnect-TopDesk

## SYNOPSIS

Disconnect from TopDesk instance.

## SYNTAX

``` Powershell
Disconnect-TopDesk [<CommonParameters>]
```

## DESCRIPTION

This command disconnects from the current TopDesk instance, clearing instance and authentication information.

## EXAMPLES

### EXAMPLE 1

``` Powershell
Disconnect-TopDesk
```

This command will disconnect from the current TopDesk instance.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This command does not accept input.

## OUTPUTS

### Output - Boolean

[Boolean]

## NOTES

This command can be useful when connecting to multiple TopDesk instances or clearing current connection.

## RELATED LINKS

[Connect-TopDesk](https://github.com/rbury/TopDeskClient/blob/master/docs/Connect-TopDesk.md)
