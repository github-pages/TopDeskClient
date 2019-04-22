---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version:
schema: 2.0.0
---

# Add-Assignment

## SYNOPSIS
Add an assignment to asset.

## SYNTAX

### Default (Default)
```
Add-Assignment -AssetID <String[]> -TargetID <String> -TargetType <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### location
```
Add-Assignment -AssetID <String[]> -LocationID <String> -BranchID <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This command will add an additional assignment to an asset.
Assignements are one of person, personGroup, Incident, Branch, location.

## EXAMPLES

### EXAMPLE 1
```
Add-Assignment -AssetID '7ac3e7e6-ac6c-5f74-a0fd-d508793adf51' -TargetID '8d446c8c-1379-4864-a682-559a9dd055b5' -TargetType 'incident'
```

Add a link to asset with unid '7ac3e7e6-ac6c-5f74-a0fd-d508793adf51' for Incident with unid '8d446c8c-1379-4864-a682-559a9dd055b5'.

## PARAMETERS

### -AssetID
The id (unid) of the asset being assigned to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: unid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetID
The id (unid) of the entity to assign to the asset.

```yaml
Type: String
Parameter Sets: Default
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TargetType
The type of entity being assigned - possible values person, personGroup, Incident, Branch.

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LocationID
The id (unid) of the location to assign to the asset.

```yaml
Type: String
Parameter Sets: location
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BranchID
The id (unid) of the branch containing the location.

```yaml
Type: String
Parameter Sets: location
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
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

```yaml
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

### The Microsoft .NET Framework types of objects that can be piped to the function or script.
### You can also include a description of the input objects.
## OUTPUTS

### The .NET Framework type of the objects that the cmdlet returns.
### You can also include a description of the returned objects.
## NOTES
Additional information about the function or script.

## RELATED LINKS

[[Set-Assignment](https://github.com/rbury/TopDeskClient/Docs/Add-Assignment.md)]()

