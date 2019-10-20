---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Disconnect-TopDesk.md
schema: 2.0.0
---

# Connect-TopDesk

## SYNOPSIS

Connect to a TopDesk instance

## SYNTAX

### DefaultConnect (Default)

``` Powershell
Connect-TopDesk -TopDeskURI <String> [<CommonParameters>]
```

### load

``` Powershell
Connect-TopDesk -TopDeskURI <String> [-Load] [<CommonParameters>]
```

### save

``` Powershell
Connect-TopDesk -TopDeskURI <String> [-Save] [<CommonParameters>]
```

## DESCRIPTION

The Connect-TopDesk  function initializes a connection to an TopDesk instance.
A connection must be initialized before running any functions that communicate with Topdesk.

By default, Connect-TopDesk will not persist connection information requiring the URI and authentication to be provided on each run.
The Save parameter is provided to persist this information for the current user on the current computer.
Each subsequent run will require the TopDesk instance URI to identify the instance and optionallly the -load parameter to use saved instance information.

## EXAMPLES

### EXAMPLE 1

``` Powershell
Connect-TopDesk -TopDeskURI 'https://contoso.topdesk.net'
```

This command will connect to the instance at https://contoso.topdesk.net and prompt to provide a username and password that have access to this tenant.

### EXAMPLE 2

``` Powershell
Connect-TopDesk -TopDeskURI 'https://contoso.topdesk.net' -Save
```

This command will connect to the instance at https://contoso.topdesk.net, prompt to provide a username and password that that have access to this tenant.
If the connection is successful, this will be saved for the current user on this computer for future connections.

### EXAMPLE 3

``` Powershell
Connect-TopDesk -TopDeskURI 'https://contoso.topdesk.net' -Load
```

This command will connect to the instance at https://contoso.topdesk.net and attempt to authenticate using the previously saved information when run with the -Save parameter.
If the connection is not successful, you will recieve a prompt requesting an authorized username and password to connect with this tenant.

## PARAMETERS

### -TopDeskURI

Supply the URI of the TopDesk instance.
This is typically in the format [https://mycompany.topdesk.net](https://mycompany.topdesk.net).

``` yaml
Type: String
Parameter Sets: (All)
Aliases: uri, url

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Save

Include the Save parameter to have the TopDeskClient remember the connection details for this instance.

Note: Saving the connection details applies to the current user on the current computer and is identified by the URI.
If initializing a connection to save the connection details for automation, run the TopDeskClient as the same user account that will run the automation on the automation machine.

``` yaml
Type: SwitchParameter
Parameter Sets: save
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Load

Include the Load parameter with the instance TopDeskURI to instruct the TopDeskClient to load previously saved information for this instance that was saved with the Save parameter.

Note: Using the load parameter with out first using the Save parameter will effectivley be the same as omitting this parameter.

``` yaml
Type: SwitchParameter
Parameter Sets: load
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This function does not accept pipeline input

## OUTPUTS

[System. Boolean]

### Return value reflects the connection state of the client.

## NOTES

The load and save parameters are only applicable to the computer and user running the script.
Using Connect-TopDesk with the save parameter as User 1 on computer 1, will have no effect on User 2.
Likewise User 1 copying thier profile to computer 2 will require User 1 to use Connect-TopDesk with the save parameter on computer 2.

## RELATED LINKS

[Disconnect-TopDesk](https://github.com/rbury/TopDeskClient/blob/master/Docs/Disconnect-TopDesk.md)

