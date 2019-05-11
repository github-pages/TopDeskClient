function New-MajorIncident
{
  <#
    .Synopsis

      Short description

    .DESCRIPTION

      Long description

    .PARAMETER <Parameter-Name>

      The description of a parameter.

    .EXAMPLE

      Example of how to use this cmdlet

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      The .NET Framework type of the objects that the cmdlet returns.
      You can also include a description of the returned objects.

    .NOTES

      Additional information about the function or script.

    .LINK
    
      The name of a related topic. The value appears on the line below the ".LINK" keyword and must be preceded by a comment symbol # or included in the comment block.
      Repeat the ".LINK" keyword for each related topic.
  #>
    [CmdletBinding(DefaultParameterSetName='byEmail',
                SupportsShouldProcess=$true,
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/New-MajorIncident.md',
                ConfirmImpact='Medium')]
    [OutputType([String], ParameterSetName = "byEmail")]

    Param (

        # The id of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byID')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callerLookupID,

        # The email of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byEmail')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupEmail,

        # The employee number of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byEmployee')]
        [ValidateLength(1, 20)]
        [string]
        $callerLookupEmployeeNumber,

        # The network login name of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byNetwork')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupNetworkLoginName,

        # The login name of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byLogin')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupLoginName,

        # Unregistered - Dynamic Name of the caller
        [Parameter(Mandatory = $true, ParameterSetName = 'unregistered')]
        [ValidateLength(1, 109)]
        [string]
        $dynamicName,

        # Unregistered / override registered - The caller branch by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $branch,

        # Unregistered / override registered - Phone number of the caller
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateLength(1, 25)]
        [string]
        $phoneNumber,

        # Unregistered / override registered - Mobile phone number of the caller
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateLength(1, 25)]
        [string]
        $mobileNumber,

        # Unregistered / override registered - Email of the caller
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateLength(1, 100)]
        [string]
        $email,

        # Unregistered / override registered - Department of the caller by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $department,

        # Unregistered / override registered - Location of the caller by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $location,

        # Unregistered / override registered - Budget holder of the caller by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $budgetHolder,

        # Unregistered / override registered - Person extra a of the caller by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $personExtraFieldA,

        # Unregistered / override registered - Person extra b of the caller by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $personExtraFieldB,

        # status of incident (firstLine, secondLine, partial), Default = firstline
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateSet('firstLine', 'secondLine', 'partial')]
        [string]
        $status,

        # brief Description of incident
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateLength(1, 80)]
        [string]
        $briefDescription,

        # initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [string]
        $request,

        # initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [string]
        $action,

        # Make action invisible - Default = $false
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [bool]
        $actionInvisibleForCaller,

        # Entry type by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $entryType,

        # Call type by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callType,

        # Category by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $categoryID,

        # Category by name
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [string]
        $categoryName,

        # Subcategory by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $subcategoryID,

        # Subcategory by name
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [string]
        $subcategoryName,

        # External number
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateLength(1, 60)]
        [string]
        $externalNumber,

        # Object by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $objectID,

        # Object by Name
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [string]
        $objectName,

        # Object Location by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $objectLocationID,

        # impact by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $impact,

        # urgency by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $urgency,

        # priority by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $priority,

        # duration by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $duration,

        # Target Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [datetime]
        $targetDate,

        # sla by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $sla,

        # On hold. On hold date will be filled accordingly
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [bool]
        $onHold,

        # operator by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operator,

        # operatorGroup by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operatorGroup,

        # supplier by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $supplier,

        # processingStatus by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $processingStatus,

        # Whether the incident is responded
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [bool]
        $responded,

        # responseDate
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [datetime]
        $responseDate,

        # Whether the incident is completed
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [bool]
        $completed,

        # Completed Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [datetime]
        $completedDate,

        # Whether the incident is closed
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [bool]
        $closed,

        # Closed Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [datetime]
        $closedDate,

        # Closure Code by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $closureCode,

        # Costs
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [float]
        $costs,

        # Rate incident, only available for closed incidents
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidateSet(1, 2, 3, 4, 5)]
        [int]
        $feedbackRating,

        # Leave feedback message on incident, only available for closed incidents and when feedbackRating is given
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [string]
        $feedbackMessage,

        # Whether the incident should be published in the Self Service Desk; only major incidents can be published
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [bool]
        $publishToSsd,

        # Free fields Tab 1
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [hashtable]
        $optionalFields1,

        # Free fields Tab 2
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [hashtable]
        $optionalFields2,

        # Link to an external system - Identifier as supplied by the external system
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $externalLinkID,

        # Link to an external system - Integer to identify the external system by
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [int]
        $externalLinkType,

        # Date of the last synchronization
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [datetime]
        $externalLinkDate

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))

        }

        if (($PSBoundParameters.ContainsKey('externalLinkID')) -and (!($PSBoundParameters.ContainsKey('externalLinkType')))) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("externalLinkType must be provided when using externalLinkID", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
        
    }

    process {

        [PSCustomObject] $newIncident = @{
            'majorCall' = $true
        }
        [System.Collections.ArrayList] $callerList = @{}
        [bool] $callerSet = $false

        switch ($PSCmdlet.ParameterSetName) {

            'byID' {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callerLookup' -Value @{ 'id' = $callerLookupID }
                break
            }

            'byEmail' {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callerLookup' -Value @{ 'email' = $callerLookupEmail }
                break
            }

            'byEmployee' {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callerLookup' -Value @{ 'employeeNumber' = $callerLookupEmployeeNumber }
                break
            }

            'byNetwork' {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callerLookup' -Value @{ 'networkLoginName' = $callerLookupNetworkLoginName }
                break
            }

            'byLogin' {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callerLookup' -Value @{ 'loginName' = $callerLookupLoginName }
                break
            }
            
            'Unregistered' {
                $null = $callerlist.Add([PSCustomObject]@{
                    'caller' = @{ 'dynamicName' = $dynamicName }
                })
                [bool]$callerSet = $true
                break
            }
           
            Default { }
        }

        if($PSBoundParameters.Keys.Count -gt 1) {
            foreach ($item in $PSBoundParameters.GetEnumerator()) {            
                switch ($item) {

                    'branch' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'branch',$branch )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'branch' = $branch }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'phoneNumber' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'phoneNumber',$phoneNumber )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'phoneNumber' = $phoneNumber }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'mobileNumber' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'mobileNumber',$mobileNumber )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'mobileNumber' = $mobileNumber }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'email' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'email',$email )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'email' = $email }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'department' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'department',$department )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'department' = $department }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'location' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'location',$location )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'location' = $location }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'budgetHolder' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'budgetHolder',$budgetHolder )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'budgetHolder' = $budgetHolder }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'personExtraFieldA' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'personExtraFieldA',$personExtraFieldA )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'personExtraFieldA' = $personExtraFieldA }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'personExtraFieldB' {
                        if($callerSet) {
                            $null = $callerList.caller.Add( 'personExtraFieldB',$personExtraFieldB )
                        } else {
                            $null = $callerList.Add( [PSCustomObject]@{
                                'caller' = @{ 'personExtraFieldB' = $personExtraFieldB }
                            } )
                            $callerSet = $true
                        }
                        break
                    }

                    'status' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'status' -Value $status
                        break
                    }

                    'briefDescription' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'briefDescription' -Value $briefDescription
                        break
                    }

                    'request' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'request' -Value $request
                        break
                    }

                    'action' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'action' -Value $action
                        break
                    }

                    'actionInvisibleForCaller' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'actionInvisibleForCaller' -Value $actionInvisibleForCaller
                        break
                    }

                    'entryType' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value @{ 'id' = $entryType }
                        break
                    }

                    'callType' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callType' -Value @{ 'id' = $callType }
                        break
                    }

                    'categoryName' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'name' = $categoryName }
                        break
                    }

                    'categoryID' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'id' = $categoryID } -Force
                        break
                    }

                    'subcategoryName' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'name' = $subcategoryName }
                        break
                    }

                    'subcategoryID' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'id' = $subcategoryID } -Force
                        break
                    }

                    'externalNumber' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalNumber' -Value $externalNumber
                        break
                    }

                    'objectName' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'name' = $objectName }
                        break
                    }

                    'objectID' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID } -Force
                        break
                    }

                    'objectLocationID' {
                        if(($PSBoundParameters.ContainsKey('objectName')) -or ($PSBoundParameters.ContainsKey('objectID'))) {
                            Write-Warning -Message "Ignoring objectLocationID parameter, objectID or objectName provided."
                        } else {
                            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'location' -Value @{ 'id' = $objectLocationID }
                        }
                        break
                    }

                    'impact' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'impact' -Value @{ 'id' = $impact }
                        break
                    }

                    'urgency' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'urgency' -Value @{ 'id' = $urgency }
                        break
                    }

                    'priority' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'priority' -Value @{ 'id' = $priority }
                        break
                    }

                    'duration' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'duration' -Value @{ 'id' = $duration }
                        break
                    }

                    'targetDate' {
                        [string] $_newTargetDate = ($targetDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'targetDate' -Value $_newTargetDate
                        break
                    }

                    'sla' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'sla' -Value @{ 'id' = $sla }
                        break
                    }

                    'onHold' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'onHold' -Value $onHold
                        break
                    }

                    'operator' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operator' -Value @{ 'id' = $operator }
                        break
                    }

                    'operatorGroup' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operatorGroup' -Value @{ 'id' = $operatorGroup }
                        break
                    }

                    'supplier' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'supplier' -Value @{ 'id' = $supplier }
                        break
                    }

                    'processingStatus' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'processingStatus' -Value @{ 'id' = $processingStatus }
                        break
                    }

                    'responded' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responded' -Value $responded
                        break
                    }

                    'responseDate' {
                        $_newResponseDate = ($responseDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responseDate' -Value $_newResponseDate
                        break
                    }

                    'completed' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completed' -Value $completed
                        break
                    }

                    'completedDate' {
                        $_newCompletedDate = ($completedDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completedDate' -Value $_newCompletedDate
                        break
                    }

                    'closed' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closed' -Value $closed
                        break
                    }

                    'closedDate' {
                        $_newClosedDate = ($closedDate | ConvertTo-ISODate)
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closedDate' -Value $_newClosedDate
                        break
                    }

                    'closureCode' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closureCode' -Value @{ 'id' = $closureCode }
                        break
                    }

                    'costs' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'costs' -Value $costs
                        break
                    }

                    'feedbackRating' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackRating' -Value $feedbackRating
                        break
                    }

                    'feedbackMessage' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackMessage' -Value $feedbackMessage
                        break
                    }

                    'optionalFields1' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $optionalFields1
                        break
                    }

                    'optionalFields2' {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields2' -Value $optionalFields2
                        break
                    }

                    'externalLinkID' {
                        if($PSBoundParameters.ContainsKey('externalLinkType')) {
                            if($PSBoundParameters.ContainsKey('externalLinkDate')) {
                                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType; 'date' = $externalLinkDate }
                            } else {
                                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType }
                            }
                        }
                        break
                    }
                    
                    Default {}
                }

            }
        }


#region removed
       <#  if($PSBoundParameters.ContainsKey('BranchID')) {
            if($callerSet) {
                $null = $callerlist.caller.Add( 'branch',$branchID )
            } else {
                $null = $callerList.Add( [PSCustomObject]@{
                    'caller' = @{ 'branch' = $branchID }
                } )
                $callerSet = $true
            }
        } #>

       <#  if($PSBoundParameters.ContainsKey('phoneNumber')) {
            if($callerSet) {
                $null = $callerList.caller.Add('phoneNumber',$phoneNumber)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'phoneNumber'=$phoneNumber}
                })
                $callerSet = $true
            }
        } #>

     <#    if($PSBoundParameters.ContainsKey('mobileNumber')) {
            if($callerSet) {
                $null = $callerList.caller.Add('mobileNumber',$mobileNumber)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'mobileNumber'=$mobileNumber}
                })
                $callerSet = $true
            }
        } #>

        <# if($PSBoundParameters.ContainsKey('email')) {
            if($callerSet) {
                $null = $callerList.caller.Add('email',$email)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'email'=$email}
                })
                $callerSet = $true
            }
        } #>

        <# if($PSBoundParameters.ContainsKey('departmentID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('department',$departmentID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'department'=$departmentID}
                })
                $callerSet = $true
            }
        } #>
        
       <#  if($PSBoundParameters.ContainsKey('locationID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('location',$locationID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'location'=$locationID}
                })
                $callerSet = $true
            }
        } #>

       <#  if($PSBoundParameters.ContainsKey('budgetHolderID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('budgetHolder',$budgetHolderID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'budgetHolder'=$budgetHolderID}
                })
                $callerSet = $true
            }
        } #>

        <# if($PSBoundParameters.ContainsKey('personExtraFieldAID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldA',$personExtraFieldAID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'personExtraFieldA'=$personExtraFieldAID}
                })
                $callerSet = $true
            }
        } #>

        <# if($PSBoundParameters.ContainsKey('personExtraFieldBID')) {
            if($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldB',$personExtraFieldBID)
            } else {
                $null = $callerList.Add([PSCustomObject]@{
                    'caller' = @{'personExtraFieldB'=$personExtraFieldBID}
                })
                $callerSet = $true
            }
        } #>

        <# if($PSBoundParameters.ContainsKey('status')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'status' -Value $status
        } #>

        <# if($PSBoundParameters.ContainsKey('briefDescription')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'briefDescription' -Value $briefDescription
        } #>

        <# if($PSBoundParameters.ContainsKey('request')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'request' -Value $request
        } #>

        <# if($PSBoundParameters.ContainsKey('action')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'action' -Value $action
        } #>

        <# if($PSBoundParameters.ContainsKey('actionInvisibleForCaller')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'actionInvisibleForCaller' -Value $actionInvisibleForCaller
        } #>

        <# if($PSBoundParameters.ContainsKey('entryTypeID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value $entryTypeID
        } #>

        <# if($PSBoundParameters.ContainsKey('callTypeID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callType' -Value $callTypeID
        } #>

       <#  if($PSBoundParameters.ContainsKey('categoryName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'name' = $categoryName }
        } #>

        <# if($PSBoundParameters.ContainsKey('categoryID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'id' = $categoryID } -Force
        } #>

        <# if($PSBoundParameters.ContainsKey('subcategoryName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'name' = $subcategoryName }
        } #>

        <# if($PSBoundParameters.ContainsKey('subcategoryID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'id' = $subcategoryID } -Force
        } #>

        <# if($PSBoundParameters.ContainsKey('externalNumber')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalNumber' -Value $externalNumber
        } #>

        <# if($PSBoundParameters.ContainsKey('objectName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'name' = $objectName }
        } #>

        <# if($PSBoundParameters.ContainsKey('objectID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID } -Force
        } #>

        <# if($PSBoundParameters.ContainsKey('objectLocationID')) {
            if(($PSBoundParameters.ContainsKey('objectName')) -or ($PSBoundParameters.ContainsKey('objectID'))) {
                Write-Warning -Message "Ignoring objectLocationID parameter, objectID or objectName provided."
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'location' -Value @{ 'id' = $objectLocationID }
            }
        } #>

        <# if($PSBoundParameters.ContainsKey('impactID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'impact' -Value $impactID
        } #>

        <# if($PSBoundParameters.ContainsKey('urgencyID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'urgency' -Value $urgencyID
        } #>

        <# if($PSBoundParameters.ContainsKey('priorityID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'priority' -Value $priorityID
        } #>

        <# if($PSBoundParameters.ContainsKey('durationID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'duration' -Value $durationID
        } #>

        <# if($PSBoundParameters.ContainsKey('targetDate')) {
            [string] $_newTargetDate = ($targetDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'targetDate' -Value $_newTargetDate
        } #>

        <# if($PSBoundParameters.ContainsKey('slaID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'sla' -Value $slaID
        } #>

        <# if($PSBoundParameters.ContainsKey('onHold')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'onHold' -Value $onHold
        } #>

        <# if($PSBoundParameters.ContainsKey('operatorID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operator' -Value @{ 'id' = $operatorID }
        } #>

        <# if($PSBoundParameters.ContainsKey('operatorgroupID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operatorGroup' -Value @{ 'id' = $operatorGroupID }
        } #>

        <# if($PSBoundParameters.ContainsKey('supplierID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'supplier' -Value @{ 'id' = $supplierID }
        } #>

        <# if($PSBoundParameters.ContainsKey('processingStatusID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'processingStatus' -Value @{ 'id' = $processingStatusID }
        } #>

       <#  if($PSBoundParameters.ContainsKey('responded')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responded' -Value $responded
        } #>

       <#  if($PSBoundParameters.ContainsKey('responseDate')) {
            $_newResponseDate = ($responseDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responseDate' -Value $_newResponseDate
        } #>

        <# if($PSBoundParameters.ContainsKey('completed')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completed' -Value $completed
        } #>

        <# if($PSBoundParameters.ContainsKey('completedDate')) {
            $_newCompletedDate = ($completedDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completedDate' -Value $_newCompletedDate
        } #>

        <# if($PSBoundParameters.ContainsKey('closed')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closed' -Value $closed
        } #>

        <# if($PSBoundParameters.ContainsKey('closedDate')) {
            $_newClosedDate = ($closedDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closedDate' -Value $_newClosedDate
        } #>

        <# if($PSBoundParameters.ContainsKey('closureCodeID')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closureCode' -Value $closureCodeID
        } #>

        <# if($PSBoundParameters.ContainsKey('costs')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'costs' -Value $costs
        } #>

        <# if($PSBoundParameters.ContainsKey('feedbackRating')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackRating' -Value $feedbackRating
        } #>

        <# if($PSBoundParameters.ContainsKey('feedbackMessage')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackMessage' -Value $feedbackMessage
        } #>

        <# if($PSBoundParameters.ContainsKey('freeFields1')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $freeFields1
        } #>

        <# if($PSBoundParameters.ContainsKey('freeFields2')) { 
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $freeFields2
        } #>

        <# if(($PSBoundParameters.ContainsKey('externalLinkID')) -and ($PSBoundParameters.ContainsKey('externalLinkType'))) {
            if($PSBoundParameters.ContainsKey('externalLinkDate')) {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType; 'date' = $externalLinkDate }
            } else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType }
            }
        } #>
#endregion

        if($callerSet) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'caller' -Value $callerList.caller
        }

        $_headerslist = @{ 'Content-Type' = 'application/json' }
        $_uri = $script:tdURI + '/tas/api/incidents/'
        $_body = (ConvertTo-Json -InputObject $newIncident -Depth 8 -Compress)

        if($PSCmdlet.ShouldProcess( $_body, 'Create' )) {
            Get-APIResponse -Method 'POST' -APIurl $_uri -Body $_body -Headers $_headerslist -tdCredential $script:tdCredential
        }

    }

    end {

    }
}
