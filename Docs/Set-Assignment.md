---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Assignment.md
schema: 2.0.0
---

# Set-Assignment

## SYNOPSIS

Short description

## SYNTAX

### Default (Default)

``` Powershell
Set-Assignment -AssetID <String> -TemplateID <String> -TargetID <String[]> [-Person] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### branches

``` Powershell
Set-Assignment -AssetID <String> -TemplateID <String> -TargetID <String[]> [-Branch] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### locations

``` Powershell
Set-Assignment -AssetID <String> -TemplateID <String> -TargetID <String[]> [-Location] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### persongroups

``` Powershell
Set-Assignment -AssetID <String> -TemplateID <String> -TargetID <String[]> [-PersonGroup] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### persons

``` Powershell
Set-Assignment -AssetID <String> -TemplateID <String> -TargetID <String[]> [-Person] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
Set-Assignment -AssetID '12345-12345-12345-1234' -TemplateID '12345-12345-12345-1234' -TargetID @('12345-12345-12345-1234')
```

## PARAMETERS

### -AssetID

The id of the asset to assign to.

``` yaml
Type: String
Parameter Sets: (All)
Aliases: unid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TemplateID

The template id specifying the type of the asset.

``` yaml
Type: String
Parameter Sets: (All)
Aliases: type_id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetID

The id of the target to be assigned to.

``` yaml
Type: String[]
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Branch

Set target type to Branch

``` yaml
Type: SwitchParameter
Parameter Sets: branches
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

Set target type to Location

``` yaml
Type: SwitchParameter
Parameter Sets: locations
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonGroup

Set target type to PersonGroup

``` yaml
Type: SwitchParameter
Parameter Sets: persongroups
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Person

Set target type to Person

``` yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

``` yaml
Type: SwitchParameter
Parameter Sets: persons
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

``` yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

``` yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

The Microsoft . NET Framework types of objects that can be piped to the function or script.
You can also include a description of the input objects.

## OUTPUTS

[PSCustomObject]

Name            MemberType      Definition
---------------------------------------------------------
Equals               Method            bool Equals(System. Object obj)
GetHashCode   Method            int GetHashCode()
GetType            Method            type GetType()
ToString            Method            string ToString()
linkErrors          NoteProperty   Object[] linkErrors=System. Object[]
modified           NoteProperty   bool modified=False
unlinkErrors      NoteProperty   Object[] unlinkErrors=System. Object[]
Sample linkErrors object with errors

{@{id=ef935e2c-f331-42bf-bbe9-8da872525de5; errorCode=value_unknown}}

## NOTES

None.

## RELATED LINKS

[Get-Assignment](https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Assignment.md)

