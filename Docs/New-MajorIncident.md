---
external help file: TopDeskClient-help.xml
Module Name: TopDeskClient
online version: https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Incident.md
schema: 2.0.0
---

# New-MajorIncident

## SYNOPSIS

Create a new Major incident

## SYNTAX

### byEmail (Default)

``` Powershell
New-MajorIncident -callerLookupEmail <String> [-branch <String>] [-phoneNumber <String>]
 [-mobileNumber <String>] [-email <String>] [-department <String>] [-location <String>]
 [-budgetHolder <String>] [-personExtraFieldA <String>] [-personExtraFieldB <String>] [-status <String>]
 [-briefDescription <String>] [-request <String>] [-action <String>] [-actionInvisibleForCaller <Boolean>]
 [-entryType <String>] [-callType <String>] [-categoryID <String>] [-categoryName <String>]
 [-subcategoryID <String>] [-subcategoryName <String>] [-externalNumber <String>] [-objectID <String>]
 [-objectName <String>] [-objectLocationID <String>] [-impact <String>] [-urgency <String>]
 [-priority <String>] [-duration <String>] [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>]
 [-operator <String>] [-operatorGroup <String>] [-supplier <String>] [-processingStatus <String>]
 [-responded <Boolean>] [-responseDate <DateTime>] [-completed <Boolean>] [-completedDate <DateTime>]
 [-closed <Boolean>] [-closedDate <DateTime>] [-closureCode <String>] [-costs <Single>]
 [-feedbackRating <Int32>] [-feedbackMessage <String>] [-publishToSsd <Boolean>] [-optionalFields1 <Hashtable>]
 [-optionalFields2 <Hashtable>] [-externalLinkID <String>] [-externalLinkType <Int32>]
 [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### byID

``` Powershell
New-MajorIncident -callerLookupID <String> [-branch <String>] [-phoneNumber <String>] [-mobileNumber <String>]
 [-email <String>] [-department <String>] [-location <String>] [-budgetHolder <String>]
 [-personExtraFieldA <String>] [-personExtraFieldB <String>] [-status <String>] [-briefDescription <String>]
 [-request <String>] [-action <String>] [-actionInvisibleForCaller <Boolean>] [-entryType <String>]
 [-callType <String>] [-categoryID <String>] [-categoryName <String>] [-subcategoryID <String>]
 [-subcategoryName <String>] [-externalNumber <String>] [-objectID <String>] [-objectName <String>]
 [-objectLocationID <String>] [-impact <String>] [-urgency <String>] [-priority <String>] [-duration <String>]
 [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>] [-operator <String>] [-operatorGroup <String>]
 [-supplier <String>] [-processingStatus <String>] [-responded <Boolean>] [-responseDate <DateTime>]
 [-completed <Boolean>] [-completedDate <DateTime>] [-closed <Boolean>] [-closedDate <DateTime>]
 [-closureCode <String>] [-costs <Single>] [-feedbackRating <Int32>] [-feedbackMessage <String>]
 [-publishToSsd <Boolean>] [-optionalFields1 <Hashtable>] [-optionalFields2 <Hashtable>]
 [-externalLinkID <String>] [-externalLinkType <Int32>] [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### byEmployee

``` Powershell
New-MajorIncident -callerLookupEmployeeNumber <String> [-branch <String>] [-phoneNumber <String>]
 [-mobileNumber <String>] [-email <String>] [-department <String>] [-location <String>]
 [-budgetHolder <String>] [-personExtraFieldA <String>] [-personExtraFieldB <String>] [-status <String>]
 [-briefDescription <String>] [-request <String>] [-action <String>] [-actionInvisibleForCaller <Boolean>]
 [-entryType <String>] [-callType <String>] [-categoryID <String>] [-categoryName <String>]
 [-subcategoryID <String>] [-subcategoryName <String>] [-externalNumber <String>] [-objectID <String>]
 [-objectName <String>] [-objectLocationID <String>] [-impact <String>] [-urgency <String>]
 [-priority <String>] [-duration <String>] [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>]
 [-operator <String>] [-operatorGroup <String>] [-supplier <String>] [-processingStatus <String>]
 [-responded <Boolean>] [-responseDate <DateTime>] [-completed <Boolean>] [-completedDate <DateTime>]
 [-closed <Boolean>] [-closedDate <DateTime>] [-closureCode <String>] [-costs <Single>]
 [-feedbackRating <Int32>] [-feedbackMessage <String>] [-publishToSsd <Boolean>] [-optionalFields1 <Hashtable>]
 [-optionalFields2 <Hashtable>] [-externalLinkID <String>] [-externalLinkType <Int32>]
 [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### byNetwork

``` Powershell
New-MajorIncident -callerLookupNetworkLoginName <String> [-branch <String>] [-phoneNumber <String>]
 [-mobileNumber <String>] [-email <String>] [-department <String>] [-location <String>]
 [-budgetHolder <String>] [-personExtraFieldA <String>] [-personExtraFieldB <String>] [-status <String>]
 [-briefDescription <String>] [-request <String>] [-action <String>] [-actionInvisibleForCaller <Boolean>]
 [-entryType <String>] [-callType <String>] [-categoryID <String>] [-categoryName <String>]
 [-subcategoryID <String>] [-subcategoryName <String>] [-externalNumber <String>] [-objectID <String>]
 [-objectName <String>] [-objectLocationID <String>] [-impact <String>] [-urgency <String>]
 [-priority <String>] [-duration <String>] [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>]
 [-operator <String>] [-operatorGroup <String>] [-supplier <String>] [-processingStatus <String>]
 [-responded <Boolean>] [-responseDate <DateTime>] [-completed <Boolean>] [-completedDate <DateTime>]
 [-closed <Boolean>] [-closedDate <DateTime>] [-closureCode <String>] [-costs <Single>]
 [-feedbackRating <Int32>] [-feedbackMessage <String>] [-publishToSsd <Boolean>] [-optionalFields1 <Hashtable>]
 [-optionalFields2 <Hashtable>] [-externalLinkID <String>] [-externalLinkType <Int32>]
 [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### byLogin

``` Powershell
New-MajorIncident -callerLookupLoginName <String> [-branch <String>] [-phoneNumber <String>]
 [-mobileNumber <String>] [-email <String>] [-department <String>] [-location <String>]
 [-budgetHolder <String>] [-personExtraFieldA <String>] [-personExtraFieldB <String>] [-status <String>]
 [-briefDescription <String>] [-request <String>] [-action <String>] [-actionInvisibleForCaller <Boolean>]
 [-entryType <String>] [-callType <String>] [-categoryID <String>] [-categoryName <String>]
 [-subcategoryID <String>] [-subcategoryName <String>] [-externalNumber <String>] [-objectID <String>]
 [-objectName <String>] [-objectLocationID <String>] [-impact <String>] [-urgency <String>]
 [-priority <String>] [-duration <String>] [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>]
 [-operator <String>] [-operatorGroup <String>] [-supplier <String>] [-processingStatus <String>]
 [-responded <Boolean>] [-responseDate <DateTime>] [-completed <Boolean>] [-completedDate <DateTime>]
 [-closed <Boolean>] [-closedDate <DateTime>] [-closureCode <String>] [-costs <Single>]
 [-feedbackRating <Int32>] [-feedbackMessage <String>] [-publishToSsd <Boolean>] [-optionalFields1 <Hashtable>]
 [-optionalFields2 <Hashtable>] [-externalLinkID <String>] [-externalLinkType <Int32>]
 [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### unregistered

``` Powershell
New-MajorIncident -dynamicName <String> [-branch <String>] [-phoneNumber <String>] [-mobileNumber <String>]
 [-email <String>] [-department <String>] [-location <String>] [-budgetHolder <String>]
 [-personExtraFieldA <String>] [-personExtraFieldB <String>] [-status <String>] [-briefDescription <String>]
 [-request <String>] [-action <String>] [-actionInvisibleForCaller <Boolean>] [-entryType <String>]
 [-callType <String>] [-categoryID <String>] [-categoryName <String>] [-subcategoryID <String>]
 [-subcategoryName <String>] [-externalNumber <String>] [-objectID <String>] [-objectName <String>]
 [-objectLocationID <String>] [-impact <String>] [-urgency <String>] [-priority <String>] [-duration <String>]
 [-targetDate <DateTime>] [-sla <String>] [-onHold <Boolean>] [-operator <String>] [-operatorGroup <String>]
 [-supplier <String>] [-processingStatus <String>] [-responded <Boolean>] [-responseDate <DateTime>]
 [-completed <Boolean>] [-completedDate <DateTime>] [-closed <Boolean>] [-closedDate <DateTime>]
 [-closureCode <String>] [-costs <Single>] [-feedbackRating <Int32>] [-feedbackMessage <String>]
 [-publishToSsd <Boolean>] [-optionalFields1 <Hashtable>] [-optionalFields2 <Hashtable>]
 [-externalLinkID <String>] [-externalLinkType <Int32>] [-externalLinkDate <DateTime>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Long description

## EXAMPLES

### EXAMPLE 1

``` Powershell
New-MajorIncident -callerLookupEmployeeNumber '11223'
```

## PARAMETERS

### -callerLookupID

The id of the Person to fill in as this incident's caller

``` yaml
Type: String
Parameter Sets: byID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -callerLookupEmail

The email of the Person to fill in as this incident's caller

``` yaml
Type: String
Parameter Sets: byEmail
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -callerLookupEmployeeNumber

The employee number of the Person to fill in as this incident's caller

``` yaml
Type: String
Parameter Sets: byEmployee
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -callerLookupNetworkLoginName

The network login name of the Person to fill in as this incident's caller

``` yaml
Type: String
Parameter Sets: byNetwork
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -callerLookupLoginName

The login name of the Person to fill in as this incident's caller

``` yaml
Type: String
Parameter Sets: byLogin
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dynamicName

Unregistered - Dynamic Name of the caller

``` yaml
Type: String
Parameter Sets: unregistered
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -branch

Unregistered / override registered - The caller branch by id

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

### -phoneNumber

Unregistered / override registered - Phone number of the caller

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

### -mobileNumber

Unregistered / override registered - Mobile phone number of the caller

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

### -email

Unregistered / override registered - Email of the caller

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

### -department

Unregistered / override registered - Department of the caller by id

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

### -location

Unregistered / override registered - Location of the caller by id

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

### -budgetHolder

Unregistered / override registered - Budget holder of the caller by id

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

### -personExtraFieldA

Unregistered / override registered - Person extra a of the caller by id

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

### -personExtraFieldB

Unregistered / override registered - Person extra b of the caller by id

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

### -status

status of incident (firstLine, secondLine, partial), Default = firstline

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

### -callType

Call type by id

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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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

### -objectID

Object by ID

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

### -objectName

Object by Name

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

### -objectLocationID

Object Location by id

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

### -impact

impact by ID

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

### -urgency

urgency by ID

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

### -priority

priority by ID

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

### -closed

Whether the incident is closed

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

### -closedDate

Closed Date

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

### -publishToSsd

Whether the incident should be published in the Self Service Desk; only major incidents can be published

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

[Get-Incident](https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Incident.md)

