---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Set-Person.md
schema: 2.0.0
---

# Get-Person

## SYNOPSIS

Short description

## SYNTAX

### Simple (Default)

``` Powershell
Get-Person -PersonID <String[]> [-Archived <Boolean>] [<CommonParameters>]
```

### List

``` Powershell
Get-Person [-List] [-Archived <Boolean>] [<CommonParameters>]
```

### BySSP

``` Powershell
Get-Person -SSPLoginName <String[]> [-Archived <Boolean>] [<CommonParameters>]
```

### ByNetworkLogin

``` Powershell
Get-Person -NetworkLoginName <String[]> [-Archived <Boolean>] [<CommonParameters>]
```

### ByEmail

``` Powershell
Get-Person -Email <String[]> [-Archived <Boolean>] [<CommonParameters>]
```

### ByLastName

``` Powershell
Get-Person -LastName <String[]> [-Archived <Boolean>] [<CommonParameters>]
```

### ByFirstName

``` Powershell
Get-Person -FirstName <String[]> [-Archived <Boolean>] [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Get-Person -List
```

## PARAMETERS

### -PersonID

ID of person to retrieve

``` yaml
Type: String[]
Parameter Sets: Simple
Aliases: unid, ID

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -List

Get a list of all persons

``` yaml
Type: SwitchParameter
Parameter Sets: List
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SSPLoginName

SSP login name to lookup for person

``` yaml
Type: String[]
Parameter Sets: BySSP
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NetworkLoginName

Network login name to lookup for person

``` yaml
Type: String[]
Parameter Sets: ByNetworkLogin
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Email

Email address to lookup for person

``` yaml
Type: String[]
Parameter Sets: ByEmail
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LastName

Last name to lookup for person

``` yaml
Type: String[]
Parameter Sets: ByLastName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FirstName

First name to lookup for person

``` yaml
Type: String[]
Parameter Sets: ByFirstName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Archived

Include archived records?

``` yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

The Microsoft . NET Framework types of objects that can be piped to the function or script.
You can also include a description of the input objects.

## OUTPUTS

The . NET Framework type of the objects that the cmdlet returns.
You can also include a description of the returned objects.

## NOTES

None.

## RELATED LINKS

[Set-Person](https://github.com/rbury/TopDeskClient/blob/master/Docs/Set-Person.md)

