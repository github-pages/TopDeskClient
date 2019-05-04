function New-Incident {
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
    [CmdletBinding(DefaultParameterSetName = 'byEmail',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/New-Incident.md',
        ConfirmImpact = 'Medium')]
    [OutputType([PSCustomObject])]

    Param (

        # The id of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byID')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byIDMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callerLookupID,

        # The email of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byEmailMajor')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupEmail,

        # The employee number of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byEmployeeMajor')]
        [ValidateLength(1, 20)]
        [string]
        $callerLookupEmployeeNumber,

        # The network login name of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byNetworkMajor')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupNetworkLoginName,

        # The login name of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'byLoginMajor')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupLoginName,

        # Unregistered - Dynamic Name of the caller
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'unregisterMajor')]
        [ValidateLength(1, 109)]
        [string]
        $dynamicName,

        # Unregistered - The caller branch by id
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $branchID,

        # Unregistered - Phone number of the caller
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidateLength(1, 25)]
        [string]
        $phoneNumber,

        # Unregistered - Mobile phone number of the caller
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidateLength(1, 25)]
        [string]
        $mobileNumber,

        # Unregistered - Email of the caller
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidateLength(1, 100)]
        [string]
        $email,

        # Unregistered - Department of the caller by id
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $departmentID,

        # Unregistered - Location of the caller by id
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $locationID,

        # Unregistered - Budget holder of the caller by id
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $budgetHolderID,

        # Unregistered - Person extra a of the caller by id
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $personExtraFieldAID,

        # Unregistered - Person extra b of the caller by id
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Unregistered')]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'unregisterMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $personExtraFieldBID,

        # status of incident (firstLine, secondLine, partial), Default = firstline
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [string]
        $request,

        # initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [string]
        $action,

        # Make action invisible - Default = $false
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [bool]
        $actionInvisibleForCaller,

        # Entry type by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $entryTypeID,

        # Call type by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callTypeID,

        # Category by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [string]
        $categoryName,

        # Subcategory by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [string]
        $subcategoryName,

        # External number
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidateLength(1, 60)]
        [string]
        $externalNumber,

        # Main incident id, required for creating a partial incident
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $mainIncidentID,

        # Object by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [string]
        $objectName,

        # Object Location by id
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $impactID,

        # urgency by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $urgencyID,

        # priority by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $priorityID,

        # duration by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $durationID,

        # Target Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [datetime]
        $targetDate,

        # sla by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $slaID,

        # On hold. On hold date will be filled accordingly
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [bool]
        $onHold,

        # operator by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operatorID,

        # operatorGroup by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operatorGroupID,

        # supplier by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $supplierID,

        # processingStatus by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $processingStatusID,

        # Whether the incident is responded
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [bool]
        $responded,

        # responseDate
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [datetime]
        $responseDate,

        # Whether the incident is completed
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [bool]
        $completed,

        # Completed Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [datetime]
        $completedDate,

        # Whether the incident is closed
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [bool]
        $closed,

        # Closed Date
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [datetime]
        $closedDate,

        # Closure Code by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $closureCodeID,

        # Costs
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [float]
        $costs,

        # Rate incident, only available for closed incidents
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [string]
        $feedbackMessage,

        # Whether the incident is a major call
        [Parameter(Mandatory = $false)]
        [bool]
        $majorCall,

        # Major call by ID
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $majorCallObjectID,

        # Whether the incident should be published in the Self Service Desk; only major incidents can be published
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [bool]
        $publishToSsd,

        # Free fields Tab 1
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [PSCustomObject]
        $freeFields1,

        # Free fields Tab 2
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [PSCustomObject]
        $freeFields2,

        # Link to an external system - Identifier as supplied by the external system
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [int]
        $externalLinkType,

        # Date of the last synchronization
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [datetime]
        $externalLinkDate

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        #TODO: If mainIncident is specified, it must be an accessable, open, unarchived second line incident. This can only be specified for partial incidents.
        #TODO: objectName or objectLocationID - parameters are mutually exclusive, providing both will ignore objectlocation parameter
        #TODO: majorCallObjectID - indicates this is a major incident, therefore cannot be used with mainIncident or majorCall parameters
        #TODO: publishToSsd requires majorCall as only major incidents can be published
        #TODO: freeFields1/2 - provide function for creating these objects to be passed to new-incident (5x each boolean, number, date, text, memo, searchlist)
        #TODO: if providing externalLinkID then externalLinkType is required
        
        #TODO! ---------------- Helper Functions -------------------
        #TODO:  /budgetholders - list of Budget Holders
        #TODO:  /incidents/call_types - list of call types
        #TODO:  /incidents/categories - list of categories
        #TODO:  /incidents/subcategories - list of subcategories
        #TODO:  /incidents/closure_codes - list of closure codes
        #TODO:  /incidents/entry_types - list of entry types
        #TODO:  /incidents/impacts - list of impacts
        #TODO:  /incidents/priorities - list of priorities
        #TODO:  /incidents/processing_status - list of processing status
    }

    process {

    }

    end {

    }
}
