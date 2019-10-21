---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Set-Incident.md
schema: 2.0.0
---

# Get-Incident

## SYNOPSIS
Short description

## SYNTAX

### Number (Default)
```
Get-Incident -Number <String> [<CommonParameters>]
```

### ByQuery
```
Get-Incident [-AssetName <String>] [-caller <String[]>] [-operator_group <String[]>] [-operator <String[]>]
 [-processing_status <String[]>] [-main_incident_id <String[]>] [-status <String[]>]
 [-caller_branch <String[]>] [-object_id <String[]>] [-linked_object_id <String[]>]
 [-linked_object_name <String[]>] [-external_link_id <String[]>] [-external_link_type <String[]>]
 [-id <String[]>] [-external_number <String[]>] [-start <Int32>] [-page_size <Int32>] [-order_by <Hashtable>]
 [-completed <Boolean>] [-closed <Boolean>] [-resolved <Boolean>] [-major_call <Boolean>] [-archived <Boolean>]
 [-target_date_start <DateTime>] [-target_date_end <DateTime>] [-call_date_start <DateTime>]
 [-call_date_end <DateTime>] [-creation_date_start <DateTime>] [-creation_date_end <DateTime>]
 [-modification_date_start <DateTime>] [-modification_date_end <DateTime>] [-closed_date_start <DateTime>]
 [-closed_date_end <DateTime>] [-fields <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
Example of how to use this cmdlet
```

## PARAMETERS

### -Number
The incident number

```yaml
Type: String
Parameter Sets: Number
Aliases: IncidentNumber

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AssetName
Retrieve only incidents that have one of the specified objects set (by object name)

```yaml
Type: String
Parameter Sets: ByQuery
Aliases: AssetID

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -caller
Retrieve only incidents reported by one of these caller ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -operator_group
Retrieve only incidents assigned to one of these operator group ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -operator
Retrieve only incidents assigned to one of these operator ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -processing_status
Retrieve only incidents with one of these processing status ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -main_incident_id
Retrieve only incidents that have one of these main incident ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Retrieve only firstLine/secondLine/partial incidents

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -caller_branch
Retrieve only incidents reported by callers from one of these branch ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -object_id
Retrieve only incidents that have one of the specified objects set (by id)

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -linked_object_id
Retrieve only incidents that are linked to one of the specified objects (by id)

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -linked_object_name
Retrieve only incidents that are linked to one of the specified objects (by object name)

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -external_link_id
Retrieve only incidents with external link id equal to one of these values

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -external_link_type
Retrieve only incidents with external link type equal to one of these values

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
Retrieve one or more incidents with the given ids

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -external_number
Retrieve one or more incidents with the given external numbers

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -start
The offset at which to start listing the incidents at

```yaml
Type: Int32
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -page_size
The amount of incidents to be returned per request ( Default 10, Max 10 000 )

```yaml
Type: Int32
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -order_by
Order the retrieved incidents, Default is sorted by creation date, descending (newest first)

```yaml
Type: Hashtable
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -completed
Retrieve only incidents that are completed / not completed

```yaml
Type: Boolean
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -closed
Retrieve only incidents that are closed / not closed

```yaml
Type: Boolean
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -resolved
Retrieve only incidents that are resolved depending on the setting

```yaml
Type: Boolean
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -major_call
Retrieve only incidents that are major calls / not major calls

```yaml
Type: Boolean
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -archived
Whether to return archived incidents

```yaml
Type: Boolean
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -target_date_start
Retrieve only incidents with target date greater or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -target_date_end
Retrieve only incidents with target date smaller or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -call_date_start
Retrieve only incidents with call date greater or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -call_date_end
Retrieve only incidents with call date smaller or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -creation_date_start
Retrieve only incidents with creation date greater or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -creation_date_end
Retrieve only incidents with creation date smaller or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -modification_date_start
Retrieve only incidents with modification date greater or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -modification_date_end
Retrieve only incidents with modification date smaller or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -closed_date_start
Retrieve only incidents with closed date greater or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -closed_date_end
Retrieve only incidents with closed date smaller or equal to this day

```yaml
Type: DateTime
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fields
Return only specified fields.

```yaml
Type: String[]
Parameter Sets: ByQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://github.com/rbury/TopDeskClient/blob/master/Docs/Set-Incident.md](https://github.com/rbury/TopDeskClient/blob/master/Docs/Set-Incident.md)

