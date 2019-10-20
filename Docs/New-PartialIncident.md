---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/New-Incident.md
schema: 2.0.0
---

# New-PartialIncident

## SYNOPSIS

Create a new partial incident

## SYNTAX

### Default (Default)

``` Powershell
New-PartialIncident -mainIncident <String> [-briefDescription <String>] [-request <String>] [-action <String>]
 [-actionInvisibleForCaller <Boolean>] [-entryType <String>] [-categoryName <String>]
 [-subcategoryName <String>] [-externalNumber <String>] [-duration <String>] [-targetDate <DateTime>]
 [-sla <String>] [-onHold <Boolean>] [-operator <String>] [-operatorGroup <String>] [-supplier <String>]
 [-processingStatus <String>] [-responded <Boolean>] [-responseDate <DateTime>] [-completed <Boolean>]
 [-completedDate <DateTime>] [-closureCode <String>] [-costs <Single>] [-feedbackRating <Int32>]
 [-feedbackMessage <String>] [-optionalFields1 <Hashtable>] [-optionalFields2 <Hashtable>]
 [-externalLinkID <String>] [-externalLinkType <Int32>] [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### byID

``` Powershell
New-PartialIncident -mainIncident <String> [-briefDescription <String>] [-request <String>] [-action <String>]
 [-actionInvisibleForCaller <Boolean>] [-entryType <String>] [-categoryID <String>] [-subcategoryID <String>]
 [-externalNumber <String>] [-duration <String>] [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>]
 [-operator <String>] [-operatorGroup <String>] [-supplier <String>] [-processingStatus <String>]
 [-responded <Boolean>] [-responseDate <DateTime>] [-completed <Boolean>] [-completedDate <DateTime>]
 [-closureCode <String>] [-costs <Single>] [-feedbackRating <Int32>] [-feedbackMessage <String>]
 [-optionalFields1 <Hashtable>] [-optionalFields2 <Hashtable>] [-externalLinkID <String>]
 [-externalLinkType <Int32>] [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
New-PartialIncedent -mainIncident '12345-12345-12345-1234'
```

## PARAMETERS

### -mainIncident

Main incident id, required for creating a partial incident.
Must be accessable, open, unarchived second line incident.

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -briefDescription

brief Description of incident

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -request

initial request - can include html tags (\<i\>\<em\>\<b\>\<strong\>\<u\>\<a\>\<br\>\<p\>\<div\>\<img\>) \<img\> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -action

initial action - can include html tags (\<i\>\<em\>\<b\>\<strong\>\<u\>\<a\>\<br\>\<p\>\<div\>\<img\>) \<img\> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actionInvisibleForCaller

Make action invisible - Default = $false

``` yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -entryType

Entry type by id

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -categoryID

Category by id

``` yaml
Type: String
Parameter Sets: byID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -categoryName

Category by name

``` yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subcategoryID

Subcategory by id

``` yaml
Type: String
Parameter Sets: byID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subcategoryName

Subcategory by name

``` yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalNumber

External number

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -duration

duration by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -targetDate

Target Date

``` yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla

sla by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -onHold

On hold.
On hold date will be filled accordingly

``` yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -operator

operator by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -operatorGroup

operatorGroup by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -supplier

supplier by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -processingStatus

processingStatus by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -responded

Whether the incident is responded

``` yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -responseDate

responseDate

``` yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -completed

Whether the incident is completed

``` yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -completedDate

Completed Date

``` yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closureCode

Closure Code by ID

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -costs

Costs

``` yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -feedbackRating

Rate incident, only available for closed incidents

``` yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -feedbackMessage

Leave feedback message on incident, only available for closed incidents and when feedbackRating is given

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -optionalFields1

Free fields Tab 1

``` yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -optionalFields2

Free fields Tab 2

``` yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalLinkID

Link to an external system - Identifier as supplied by the external system

``` yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalLinkType

Link to an external system - Integer to identify the external system by

``` yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalLinkDate

Date of the last synchronization

``` yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

The . NET Framework type of the objects that the cmdlet returns.
You can also include a description of the returned objects.

## NOTES

None.

## RELATED LINKS

[New-Incident](https://github.com/rbury/TopDeskClient/blob/master/Docs/New-Incident.md)

