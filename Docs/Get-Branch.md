---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/docs/Get-Branch.md
schema: 2.0.0
---

# Get-Branch

## SYNOPSIS

Retrieve branch information from TopDesk

## SYNTAX

### Details (Default)

``` Powershell
Get-Branch -BranchID <String[]> [<CommonParameters>]
```

### List

``` Powershell
Get-Branch [-List] [<CommonParameters>]
```

### BranchName

``` Powershell
Get-Branch -BranchName <String> [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Example of how to use this cmdlet
```

## PARAMETERS

### -BranchID

Name of branch to retrieve details for

```yaml
Type: String[]
Parameter Sets: Details
Aliases: id, unid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -List

Get list of branches

```yaml
Type: SwitchParameter
Parameter Sets: List
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BranchName

Branch Name

```yaml
Type: String
Parameter Sets: BranchName
Aliases: name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Input - ToDo

The Microsoft .NET Framework types of objects that can be piped to the function or script.
You can also include a description of the input objects.

## OUTPUTS

### Output - ToDo

The .NET Framework type of the objects that the cmdlet returns.
You can also include a description of the returned objects.

## NOTES

Additional information about the function or script.

## RELATED LINKS

[Get-Branch](https://github.com/rbury/TopDeskClient/blob/master/docs/Get-Branch.md)
