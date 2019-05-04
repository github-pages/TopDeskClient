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
        ConfirmImpact = 'Medium',
        SupportsShouldProcess = $true)]
    [OutputType([PSCustomObject])]

    Param (

        # The id of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byID')]
        [Parameter(Mandatory = $true, ParameterSetName = 'byIDMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callerLookupID,

        # The email of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byEmail')]
        [Parameter(Mandatory = $true, ParameterSetName = 'byEmailMajor')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupEmail,

        # The employee number of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byEmployee')]
        [Parameter(Mandatory = $true, ParameterSetName = 'byEmployeeMajor')]
        [ValidateLength(1, 20)]
        [string]
        $callerLookupEmployeeNumber,

        # The network login name of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byNetwork')]
        [Parameter(Mandatory = $true, ParameterSetName = 'byNetworkMajor')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupNetworkLoginName,

        # The login name of the Person to fill in as this incident's caller
        [Parameter(Mandatory = $true, ParameterSetName = 'byLogin')]
        [Parameter(Mandatory = $true, ParameterSetName = 'byLoginMajor')]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupLoginName,

        # Unregistered - Dynamic Name of the caller
        [Parameter(Mandatory = $true, ParameterSetName = 'unregistered')]
        [Parameter(Mandatory = $true, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $branchID,

        # Unregistered / override registered - Phone number of the caller
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
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
        [Parameter(Mandatory = $false, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $departmentID,

        # Unregistered / override registered - Location of the caller by id
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
        $locationID,

        # Unregistered / override registered - Budget holder of the caller by id
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
        $budgetHolderID,

        # Unregistered / override registered - Person extra a of the caller by id
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
        $personExtraFieldAID,

        # Unregistered / override registered - Person extra b of the caller by id
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

        # Main incident id, required for creating a partial incident. Must be accessable, open, unarchived second line incident.
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
        [Parameter(Mandatory = $true, ParameterSetName = 'byIDMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmailMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployeeMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetworkMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLoginMajor')]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregisteredMajor')]
        [switch]
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

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))

        }

        if (($PSBoundParameters.ContainsKey('externalLinkID')) -and (!($PSBoundParameters.ContainsKey('externalLinkType')))) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("externalLinkType must be provided when using externalLinkID", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
        
    }

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'byID' {
                
                $newIncident = [PSCustomObject]@{
                    callerLookup = @{id=$callerLookupID}
                }

                [System.Collections.ArrayList]$callerList = @{}
                [bool]$callerSet = $false

                if($PSBoundParameters.ContainsKey('BranchID')) {

                    $null = $callerlist.Add([PSCustomObject]@{
                        'caller' = @{'branch'=$branchID}
                    })
                    $callerSet = $true
                }

                if($PSBoundParameters.ContainsKey('phoneNumber')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('phoneNumber',$phoneNumber)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'phoneNumber'=$phoneNumber}
                        })
                        $callerSet = $true
                    }
                }

                if($PSBoundParameters.ContainsKey('mobileNumber')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('mobileNumber',$mobileNumber)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'mobileNumber'=$mobileNumber}
                        })
                        $callerSet = $true
                    }
                }

                if($PSBoundParameters.ContainsKey('email')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('email',$email)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'email'=$email}
                        })
                        $callerSet = $true
                    }
                }

                if($PSBoundParameters.ContainsKey('departmentID')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('department',$departmentID)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'department'=$departmentID}
                        })
                        $callerSet = $true
                    }
                }
                
                if($PSBoundParameters.ContainsKey('locationID')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('location',$locationID)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'location'=$locationID}
                        })
                        $callerSet = $true
                    }
                }

                if($PSBoundParameters.ContainsKey('budgetHolderID')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('budgetHolder',$budgetHolderID)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'budgetHolder'=$budgetHolderID}
                        })
                        $callerSet = $true
                    }
                }

                if($PSBoundParameters.ContainsKey('personExtraFieldAID')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('personExtraFieldA',$personExtraFieldAID)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'personExtraFieldA'=$personExtraFieldAID}
                        })
                        $callerSet = $true
                    }
                }

                if($PSBoundParameters.ContainsKey('personExtraFieldBID')) {
                    if($callerSet) {
                        $null = $callerList.caller.Add('personExtraFieldB',$personExtraFieldBID)
                    } else {
                        $null = $callerList.Add([PSCustomObject]@{
                            'caller' = @{'personExtraFieldB'=$personExtraFieldBID}
                        })
                        $callerSet = $true
                    }
                }

                if($callerSet) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'caller' -Value $callerList.caller
                }

                if($PSBoundParameters.ContainsKey('status')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'status' -Value $status
                }

                if($PSBoundParameters.ContainsKey('briefDescription')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'briefDescription' -Value $briefDescription
                }

                if($PSBoundParameters.ContainsKey('request')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'request' -Value $request
                }

                if($PSBoundParameters.ContainsKey('action')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'action' -Value $action
                }

                if($PSBoundParameters.ContainsKey('actionInvisibleForCaller')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'actionInvisibleForCaller' -Value $actionInvisibleForCaller
                }

                if($PSBoundParameters.ContainsKey('entryTypeID')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value $entryTypeID
                }

                if($PSBoundParameters.ContainsKey('callTypeID')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callType' -Value $callTypeID
                }

                if($PSBoundParameters.ContainsKey('categoryName')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'name' = $categoryName }
                }

                if($PSBoundParameters.ContainsKey('categoryID')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'id' = $categoryID } -Force
                }

                if($PSBoundParameters.ContainsKey('subcategoryName')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'name' = $subcategoryName }
                }

                if($PSBoundParameters.ContainsKey('subcategoryID')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'id' = $subcategoryID } -Force
                }

                if($PSBoundParameters.ContainsKey('externalNumber')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalNumber' -Value $externalNumber
                }

                if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'mainIncident' -Value @{ 'id' = $mainIncidentID }
                }

                if($PSBoundParameters.ContainsKey('objectName')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring objectName parameter, this cannot be set for partial incidents"
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'name' = $objectName }
                    }
                }

                if($PSBoundParameters.ContainsKey('objectID')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring objectID parameter, this cannot be set for partial incidents"
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID } -Force
                    }
                }

                if($PSBoundParameters.ContainsKey('objectLocationID')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring objectID parameter, this cannot be set for partial incidents"
                    } elseif(($PSBoundParameters.ContainsKey('objectName')) -or ($PSBoundParameters.ContainsKey('objectID'))) {
                        Write-Warning -Message "Ignoring objectLocationID parameter, objectID or objectName provided and superseed this parameter"
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID }
                    }
                }

                if($PSBoundParameters.ContainsKey('impactID')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring impactID parameter, this cannot be set for partial incidents. Impact will inherit from Major."
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'impact' -Value $impactID
                    }
                }

                if($PSBoundParameters.ContainsKey('urgencyID')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring urgencyID parameter, this cannot be set for partial incidents. urgency will inherit from Major."
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'urgency' -Value $urgencyID
                    }
                }

                if($PSBoundParameters.ContainsKey('priorityID')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring priorityID parameter, this cannot be set for partial incidents. priority will inherit from Major."
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'priority' -Value $priorityID
                    }
                }

                if($PSBoundParameters.ContainsKey('durationID')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'duration' -Value $durationID
                }

                if($PSBoundParameters.ContainsKey('targetDate')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'targetDate' -Value $targetDate
                }

                if($PSBoundParameters.ContainsKey('slaID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'sla' -Value $slaID
                }

                if($PSBoundParameters.ContainsKey('onHold')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'onHold' -Value $onHold
                }

                if($PSBoundParameters.ContainsKey('operatorID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operator' -Value @{ 'id' = $operatorID }
                }

                if($PSBoundParameters.ContainsKey('operatorgroupID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operatorGroup' -Value @{ 'id' = $operatorGroupID }
                }

                if($PSBoundParameters.ContainsKey('supplierID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'supplier' -Value @{ 'id' = $supplierID }
                }

                if($PSBoundParameters.ContainsKey('processingStatusID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'processingStatus' -Value @{ 'id' = $processingStatusID }
                }

                if($PSBoundParameters.ContainsKey('responded')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responded' -Value $responded
                }

                if($PSBoundParameters.ContainsKey('responseDate')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responseDate' -Value $responseDate
                }

                if($PSBoundParameters.ContainsKey('completed')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completed' -Value $completed
                }

                if($PSBoundParameters.ContainsKey('completedDate')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completedDate' -Value $completedDate
                }

                if($PSBoundParameters.ContainsKey('closed')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring closed parameter, this cannot be set for partial incidents. Use completed parameter."
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closed' -Value $closed
                    }
                }

                if($PSBoundParameters.ContainsKey('closedDate')) {
                    if($PSBoundParameters.ContainsKey('mainIncidentID')) {
                        Write-Warning -Message "Ignoring closedDate parameter, this cannot be set for partial incidents. Use completedDate parameter."
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closedDate' -Value $closedDate
                    }
                }

                if($PSBoundParameters.ContainsKey('closureCodeID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closureCode' -Value $closureCodeID
                }

                if($PSBoundParameters.ContainsKey('costs')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'costs' -Value $costs
                }

                if($PSBoundParameters.ContainsKey('feedbackRating')) {
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackRating' -Value $feedbackRating
                }

                if($PSBoundParameters.ContainsKey('feedbackMessage')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackMessage' -Value $feedbackMessage
                }

                if($PSBoundParameters.ContainsKey('majorCallObjectID')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'majorCallObject' -Value @{ 'id' = $majorCallObjectID}
                }

                if($PSBoundParameters.ContainsKey('freeFields1')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $freeFields1
                }

                if($PSBoundParameters.ContainsKey('freeFields2')) { 
                    Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $freeFields2
                }

                if(($PSBoundParameters.ContainsKey('externalLinkID')) -and ($PSBoundParameters.ContainsKey('externalLinkType'))) {
                    if($PSBoundParameters.ContainsKey('externalLinkDate')) {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType; 'date' = $externalLinkDate }
                    } else {
                        Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType }
                    }
                }

                $_headerslist = @{ 'Content-Type' = 'application/json' }
                $_uri = $script:tdURI + '/tas/api/incidents/'

                if($PSCmdlet.ShouldProcess) {
                    Get-APIResponse -Method 'POST' -APIurl $_uri -Body (ConvertTo-Json -InputObject $newIncident -Depth 8 -Compress) -Headers $_headerslist -tdCredential $script:tdCredential
                }

                break
            }

            'byIDMajor' {
                break
            }
            'byEmail' {
                break
            }
            'byEmailMajor' {
                break
            }
            'byEmployee' {
                break
            }
            'byEmployeeMajor' {
                break
            }
            'byNetwork' {
                break
            }
            'byNetworkMajor' {
                break
            }
            'byLogin' {
                break
            }
            'byLoginMajor' {
                break
            }
            'Unregistered' {
                break
            }
            'UnregisteredMajor' {
                break
            }
            Default { }
        }

    }

    end {

    }
}
