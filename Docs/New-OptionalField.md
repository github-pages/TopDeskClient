---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version:
schema: 2.0.0
---

# New-OptionalField

## SYNOPSIS

Create a new option field

## SYNTAX

### Default (Default)

``` Powershell
New-OptionalField [-optionalField <Int32>] [-boolean <Boolean[]>] [-number <Single[]>] [-date <DateTime[]>]
 [-text <String[]>] [-memo <String[]>] [-searchlist <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### byNumber

``` Powershell
New-OptionalField [-optionalField <Int32>] [-booleanHash <Hashtable>] [-numberHash <Hashtable>]
 [-DateHash <Hashtable>] [-TextHash <Hashtable>] [-memoHash <Hashtable>] [-searchlistHash <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
New-OptionalField
```

## PARAMETERS

### -optionalField

OptionalFields to create ( 1 or 2 ) - Default 1

``` yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -boolean

Boolean values in order (1-5)

``` yaml
Type: Boolean[]
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -booleanHash

Boolean values assigned by number

``` yaml
Type: Hashtable
Parameter Sets: byNumber
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -number

Numeric values in order (1-5)

``` yaml
Type: Single[]
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -numberHash

Numeric values assigned by number

``` yaml
Type: Hashtable
Parameter Sets: byNumber
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -date

Date values in order (1-5)

``` yaml
Type: DateTime[]
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DateHash

Date values assigned by number

``` yaml
Type: Hashtable
Parameter Sets: byNumber
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -text

Text values in order (1-5)

``` yaml
Type: String[]
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TextHash

Text values assigned by number

``` yaml
Type: Hashtable
Parameter Sets: byNumber
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -memo

Memo values in order (1-5)

``` yaml
Type: String[]
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -memoHash

Memo values assigned by number

``` yaml
Type: Hashtable
Parameter Sets: byNumber
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchlist

Searchlist values in order (1-5)

``` yaml
Type: String[]
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchlistHash

Searchlist values assigned by number

``` yaml
Type: Hashtable
Parameter Sets: byNumber
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

The . NET Framework type of the objects that the cmdlet returns.
You can also include a description of the returned objects.

## NOTES

None.

## RELATED LINKS

