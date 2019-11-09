function New-Incident {
    <#
    .Synopsis

      Create a new Incident.

    .DESCRIPTION

      This cmdlet will create a new incident in the connected TopDesk environment.

    .EXAMPLE

      New-Incident -CallerLookupEmail employee1@contoso.com -status SecondLine -BreifDescriptoin 'Problem with my printer' -Request 'Blank pages printing instead of document.' -CategoryName 'Hardware' -SubCategoryName 'Printer' -ObjectName 'MyPrinter01'

      Create a new 2nd line incident for caller with email employee1@contoso.com, filling in the brief description with 'Problem with my printer', initial request 'Blank pages printing instead of document' under Hardware / Printer category / subcategory and involve asset 'MyPrinter01'.

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      The .NET Framework type of the objects that the cmdlet returns.
      You can also include a description of the returned objects.

    .NOTES

      Additional information about the function or script.

    .LINK

      https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Incident.md

  #>

    [CmdletBinding(DefaultParameterSetName = 'byEmail',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/New-Incident.md',
        ConfirmImpact = 'Medium',
        SupportsShouldProcess = $true)]
    [OutputType([PSCustomObject])]

    Param (

        [Parameter(Mandatory = $true, ParameterSetName = 'byID', HelpMessage = "The id of the Person to fill in as this incident's caller")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callerLookupID,

        [Parameter(Mandatory = $true, ParameterSetName = 'byEmail', HelpMessage = "The email of the Person to fill in as this incident's caller")]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupEmail,

        [Parameter(Mandatory = $true, ParameterSetName = 'byEmployee', HelpMessage = "The employee number of the Person to fill in as this incident's caller")]
        [ValidateLength(1, 20)]
        [string]
        $callerLookupEmployeeNumber,

        [Parameter(Mandatory = $true, ParameterSetName = 'byNetwork', HelpMessage = "The network login name of the Person to fill in as this incident's caller")]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupNetworkLoginName,

        [Parameter(Mandatory = $true, ParameterSetName = 'byLogin', HelpMessage = "The login name of the Person to fill in as this incident's caller")]
        [ValidateLength(1, 100)]
        [string]
        $callerLookupLoginName,

        [Parameter(Mandatory = $true, ParameterSetName = 'unregistered', HelpMessage = "Unregistered - Dynamic Name of the caller")]
        [ValidateLength(1, 109)]
        [string]
        $dynamicName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override registered branch id of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override registered branch id of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override registered branch id of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override registered branch id of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override registered branch id of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Branch id of the unregistered caller")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $branch,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the Phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the Phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the Phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the Phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the Phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Phone number of the unregistered caller")]
        [ValidateLength(1, 25)]
        [string]
        $phoneNumber,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the Mobile phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the Mobile phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the Mobile phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the Mobile phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the Mobile phone number of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Mobile phone number of the unregistered caller")]
        [ValidateLength(1, 25)]
        [string]
        $mobileNumber,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the Email of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the Email of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the Email of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the Email of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the Email of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Email of the unregistered caller")]
        [ValidateLength(1, 100)]
        [string]
        $email,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the caller Department by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the caller Department by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the caller Department by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the caller Department by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the caller Department by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "caller Department by Name")]
        [ValidateNotNullOrEmpty()]
        [string]
        $departmentName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the caller Department by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the caller Department by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the caller Department by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the caller Department by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the caller Department by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "caller Department by Id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $departmentId,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the Location of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the Location of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the Location of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the Location of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the Location of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Location of the unregistered caller")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $location,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the caller Budget holder by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the caller Budget holder by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the caller Budget holder by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the caller Budget holder by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the caller Budget holder by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "caller Budget holder by Name")]
        [ValidateNotNullOrEmpty()]
        [string]
        $budgetHolderName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the caller Budget holder by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the caller Budget holder by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the caller Budget holder by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the caller Budget holder by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the caller Budget holder by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "caller Budget holder by Id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $budgetHolderId,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the caller Person extra a by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the caller Person extra a by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the caller Person extra a by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the caller Person extra a by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the caller Person extra a by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "caller Person extra a by Name")]
        [ValidateNotNullOrEmpty()]
        [string]
        $personExtraFieldAName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the caller Person extra a by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the caller Person extra a by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the caller Person extra a by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the caller Person extra a by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the caller Person extra a by Id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "caller Person extra a by Id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $personExtraFieldAId,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Override the Person extra b of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Override the Person extra b of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Override the Person extra b of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Override the Person extra b of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Override the Person extra b of the caller")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "The Person extra b of the unregsitered caller")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $personExtraFieldB,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "status of incident (firstLine, secondLine, partial), Default = firstline")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "status of incident (firstLine, secondLine, partial), Default = firstline")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "status of incident (firstLine, secondLine, partial), Default = firstline")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "status of incident (firstLine, secondLine, partial), Default = firstline")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "status of incident (firstLine, secondLine, partial), Default = firstline")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "status of incident (firstLine, secondLine, partial), Default = firstline")]
        [ValidateSet('firstLine', 'secondLine', 'partial')]
        [string]
        $status,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "brief Description of incident")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "brief Description of incident")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "brief Description of incident")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "brief Description of incident")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "brief Description of incident")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "brief Description of incident")]
        [ValidateLength(1, 80)]
        [string]
        $briefDescription,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "initial request - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [string]
        $request,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "initial action - can include html tags (<i><em><b><strong><u><a><br><p><div><img>) <img> must be 450x450 or smaller, base64 encoded (gif, png, bmp, pcx, iff, ras, pnm, psd, jpg)")]
        [string]
        $action,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Make action invisible - Default = false")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Make action invisible - Default = false")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Make action invisible - Default = false")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Make action invisible - Default = false")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Make action invisible - Default = false")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Make action invisible - Default = false")]
        [bool]
        $actionInvisibleForCaller,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Entry type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Entry type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Entry type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Entry type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Entry type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Entry type Name")]
        [ValidateNotNullOrEmpty()]
        [string]
        $entryTypeName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Entry type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Entry type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Entry type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Entry type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Entry type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Entry type id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $entryTypeId,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Call type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Call type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Call type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Call type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Call type Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Call type Name")]
        [ValidateNotNullOrEmpty()]
        [string]
        $callTypeName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Call type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Call type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Call type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Call type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Call type id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Call type id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $callTypeId,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Category by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Category by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Category by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Category by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Category by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Category by id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $categoryID,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Category by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Category by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Category by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Category by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Category by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Category by name")]
        [string]
        $categoryName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Subcategory by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Subcategory by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Subcategory by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Subcategory by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Subcategory by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Subcategory by id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $subcategoryID,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Subcategory by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Subcategory by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Subcategory by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Subcategory by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Subcategory by name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Subcategory by name")]
        [string]
        $subcategoryName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "External number")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "External number")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "External number")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "External number")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "External number")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "External number")]
        [ValidateLength(1, 60)]
        [string]
        $externalNumber,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Object by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Object by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Object by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Object by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Object by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Object by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $objectID,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Object by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Object by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Object by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Object by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Object by Name")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Object by Name")]
        [string]
        $objectName,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Object Location by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Object Location by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Object Location by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Object Location by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Object Location by id")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Object Location by id")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $objectLocationID,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "impact by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "impact by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "impact by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "impact by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "impact by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "impact by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $impact,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "urgency by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "urgency by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "urgency by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "urgency by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "urgency by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "urgency by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $urgency,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "priority by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "priority by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "priority by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "priority by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "priority by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "priority by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $priority,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "duration by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "duration by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "duration by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "duration by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "duration by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "duration by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $duration,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Target Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Target Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Target Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Target Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Target Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Target Date")]
        [datetime]
        $targetDate,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "sla by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "sla by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "sla by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "sla by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "sla by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "sla by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $sla,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "On hold. On hold date will be filled accordingly")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "On hold. On hold date will be filled accordingly")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "On hold. On hold date will be filled accordingly")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "On hold. On hold date will be filled accordingly")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "On hold. On hold date will be filled accordingly")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "On hold. On hold date will be filled accordingly")]
        [bool]
        $onHold,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "operator by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "operator by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "operator by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "operator by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "operator by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "operator by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operator,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "operatorGroup by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "operatorGroup by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "operatorGroup by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "operatorGroup by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "operatorGroup by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "operatorGroup by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $operatorGroup,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "supplier by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "supplier by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "supplier by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "supplier by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "supplier by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "supplier by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $supplier,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "processingStatus by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "processingStatus by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "processingStatus by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "processingStatus by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "processingStatus by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "processingStatus by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $processingStatus,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Whether the incident is responded")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Whether the incident is responded")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Whether the incident is responded")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Whether the incident is responded")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Whether the incident is responded")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Whether the incident is responded")]
        [bool]
        $responded,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "responseDate")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "responseDate")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "responseDate")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "responseDate")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "responseDate")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "responseDate")]
        [datetime]
        $responseDate,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Whether the incident is completed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Whether the incident is completed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Whether the incident is completed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Whether the incident is completed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Whether the incident is completed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Whether the incident is completed")]
        [bool]
        $completed,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Completed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Completed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Completed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Completed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Completed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Completed Date")]
        [datetime]
        $completedDate,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Whether the incident is closed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Whether the incident is closed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Whether the incident is closed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Whether the incident is closed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Whether the incident is closed")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Whether the incident is closed")]
        [bool]
        $closed,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Closed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Closed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Closed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Closed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Closed Date")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Closed Date")]
        [datetime]
        $closedDate,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Closure Code by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Closure Code by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Closure Code by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Closure Code by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Closure Code by ID")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Closure Code by ID")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $closureCode,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Costs")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Costs")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Costs")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Costs")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Costs")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Costs")]
        [float]
        $costs,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Rate incident, only available for closed incidents")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Rate incident, only available for closed incidents")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Rate incident, only available for closed incidents")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Rate incident, only available for closed incidents")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Rate incident, only available for closed incidents")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Rate incident, only available for closed incidents")]
        [ValidateSet(1, 2, 3, 4, 5)]
        [int]
        $feedbackRating,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Leave feedback message on incident, only available for closed incidents and when feedbackRating is given")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Leave feedback message on incident, only available for closed incidents and when feedbackRating is given")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Leave feedback message on incident, only available for closed incidents and when feedbackRating is given")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Leave feedback message on incident, only available for closed incidents and when feedbackRating is given")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Leave feedback message on incident, only available for closed incidents and when feedbackRating is given")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Leave feedback message on incident, only available for closed incidents and when feedbackRating is given")]
        [string]
        $feedbackMessage,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Incident is attached to a Major Call")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Incident is attached to a Major Call")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Incident is attached to a Major Call")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Incident is attached to a Major Call")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Incident is attached to a Major Call")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Incident is attached to a Major Call")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $majorCallObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Free fields Tab 1")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Free fields Tab 1")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Free fields Tab 1")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Free fields Tab 1")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Free fields Tab 1")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Free fields Tab 1")]
        [hashtable]
        $optionalFields1,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Free fields Tab 2")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Free fields Tab 2")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Free fields Tab 2")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Free fields Tab 2")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Free fields Tab 2")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Free fields Tab 2")]
        [hashtable]
        $optionalFields2,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Link to an external system - Identifier as supplied by the external system")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Link to an external system - Identifier as supplied by the external system")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Link to an external system - Identifier as supplied by the external system")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Link to an external system - Identifier as supplied by the external system")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Link to an external system - Identifier as supplied by the external system")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Link to an external system - Identifier as supplied by the external system")]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $externalLinkID,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Link to an external system - Integer to identify the external system by")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Link to an external system - Integer to identify the external system by")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Link to an external system - Integer to identify the external system by")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Link to an external system - Integer to identify the external system by")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Link to an external system - Integer to identify the external system by")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Link to an external system - Integer to identify the external system by")]
        [int]
        $externalLinkType,

        [Parameter(Mandatory = $false, ParameterSetName = 'byID', HelpMessage = "Date of the last synchronization")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmail', HelpMessage = "Date of the last synchronization")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byEmployee', HelpMessage = "Date of the last synchronization")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byNetwork', HelpMessage = "Date of the last synchronization")]
        [Parameter(Mandatory = $false, ParameterSetName = 'byLogin', HelpMessage = "Date of the last synchronization")]
        [Parameter(Mandatory = $false, ParameterSetName = 'unregistered', HelpMessage = "Date of the last synchronization")]
        [datetime]
        $externalLinkDate

    )

    begin {

        if (!($script:tdConnected)) {
            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))
        }

        #TODO: Move this to parameter validation
        if (($PSBoundParameters.ContainsKey('externalLinkID')) -and (!($PSBoundParameters.ContainsKey('externalLinkType')))) {
            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("externalLinkType must be provided when using externalLinkID", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))
        }

    }

    process {

        [PSCustomObject] $newIncident = @{ }
        [System.Collections.ArrayList] $callerList = @{ }
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
        }

        if ($PSBoundParameters.ContainsKey('BranchID')) {
            if ($callerSet) {
                $null = $callerlist.caller.Add( 'branch', $branch )
            }
            else {
                $null = $callerList.Add( [PSCustomObject]@{
                        'caller' = @{ 'branch' = $branch }
                    } )
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('phoneNumber')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('phoneNumber', $phoneNumber)
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'phoneNumber' = $phoneNumber }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('mobileNumber')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('mobileNumber', $mobileNumber)
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'mobileNumber' = $mobileNumber }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('email')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('email', $email)
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'email' = $email }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('departmentName')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('department', @{ 'name' = $departmentName })
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'department' = @{ 'name' = $departmentName} }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('departmentId')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('department', @{ 'id' = $departmentId })
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'department' = @{ 'id' = $departmentId} }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('location')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('location', $location)
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'location' = $location }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('budgetHolderName')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('budgetHolder', @{ 'name' = $budgetHolderName })
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'budgetHolder' = @{ 'name' = $budgetHolderName } }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('budgetHolderId')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('budgetHolder', @{ 'id' = $budgetHolderId })
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'budgetHolder' = @{ 'id' = $budgetHolderId } }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('personExtraFieldAName')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldA', @{ 'name' = $personExtraFieldAName } )
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'personExtraFieldA' = @{ 'name' = $personExtraFieldAName } }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('personExtraFieldAId')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldA', @{ 'id' = $personExtraFieldAId } )
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'personExtraFieldA' = @{ 'id' = $personExtraFieldAId } }
                    })
                $callerSet = $true
            }
        }

        if ($PSBoundParameters.ContainsKey('personExtraFieldB')) {
            if ($callerSet) {
                $null = $callerList.caller.Add('personExtraFieldB', $personExtraFieldB)
            }
            else {
                $null = $callerList.Add([PSCustomObject]@{
                        'caller' = @{'personExtraFieldB' = $personExtraFieldB }
                    })
                $callerSet = $true
            }
        }

        if ($callerSet) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'caller' -Value $callerList.caller
        }

        if ($PSBoundParameters.ContainsKey('status')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'status' -Value $status
        }

        if ($PSBoundParameters.ContainsKey('briefDescription')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'briefDescription' -Value $briefDescription
        }

        if ($PSBoundParameters.ContainsKey('request')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'request' -Value $request
        }

        if ($PSBoundParameters.ContainsKey('action')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'action' -Value $action
        }

        if ($PSBoundParameters.ContainsKey('actionInvisibleForCaller')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'actionInvisibleForCaller' -Value $actionInvisibleForCaller
        }

        if ($PSBoundParameters.ContainsKey('entryTypeName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value @{ 'name' = $entryTypeName }
        }

        if ($PSBoundParameters.ContainsKey('entryTypeId')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'entryType' -Value @{ 'id' = $entryTypeId }
        }

        if ($PSBoundParameters.ContainsKey('callTypeName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callType' -Value @{ 'name' = $callTypeName }
        }

        if ($PSBoundParameters.ContainsKey('callTypeId')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'callType' -Value @{ 'id' = $callTypeId }
        }

        if ($PSBoundParameters.ContainsKey('categoryName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'name' = $categoryName }
        }

        if ($PSBoundParameters.ContainsKey('categoryID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'category' -Value @{ 'id' = $categoryID } -Force
        }

        if ($PSBoundParameters.ContainsKey('subcategoryName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'name' = $subcategoryName }
        }

        if ($PSBoundParameters.ContainsKey('subcategoryID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'subcategory' -Value @{ 'id' = $subcategoryID } -Force
        }

        if ($PSBoundParameters.ContainsKey('externalNumber')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalNumber' -Value $externalNumber
        }

        if ($PSBoundParameters.ContainsKey('objectName')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'name' = $objectName }
        }

        if ($PSBoundParameters.ContainsKey('objectID')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'object' -Value @{ 'id' = $objectID } -Force
        }

        if ($PSBoundParameters.ContainsKey('objectLocationID')) {
            if (($PSBoundParameters.ContainsKey('objectName')) -or ($PSBoundParameters.ContainsKey('objectID'))) {
                Write-Warning -Message "Ignoring objectLocationID parameter, objectID or objectName provided."
            }
            else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'location' -Value @{ 'id' = $objectLocationID }
            }
        }

        if ($PSBoundParameters.ContainsKey('impact')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'impact' -Value @{'id' = $impact }
        }

        if ($PSBoundParameters.ContainsKey('urgency')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'urgency' -Value @{'id' = $urgency }
        }

        if ($PSBoundParameters.ContainsKey('priority')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'priority' -Value @{ 'id' = $priority }
        }

        if ($PSBoundParameters.ContainsKey('duration')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'duration' -Value @{ 'id' = $duration }
        }

        if ($PSBoundParameters.ContainsKey('targetDate')) {
            [string] $_newTargetDate = ($targetDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'targetDate' -Value $_newTargetDate
        }

        if ($PSBoundParameters.ContainsKey('sla')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'sla' -Value @{ 'id' = $sla }
        }

        if ($PSBoundParameters.ContainsKey('onHold')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'onHold' -Value $onHold
        }

        if ($PSBoundParameters.ContainsKey('operator')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operator' -Value @{ 'id' = $operator }
        }

        if ($PSBoundParameters.ContainsKey('operatorgroup')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'operatorGroup' -Value @{ 'id' = $operatorGroupID }
        }

        if ($PSBoundParameters.ContainsKey('supplier')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'supplier' -Value @{ 'id' = $supplierID }
        }

        if ($PSBoundParameters.ContainsKey('processingStatus')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'processingStatus' -Value @{ 'id' = $processingStatusID }
        }

        if ($PSBoundParameters.ContainsKey('responded')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responded' -Value $responded
        }

        if ($PSBoundParameters.ContainsKey('responseDate')) {
            $_newResponseDate = ($responseDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'responseDate' -Value $_newResponseDate
        }

        if ($PSBoundParameters.ContainsKey('completed')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completed' -Value $completed
        }

        if ($PSBoundParameters.ContainsKey('completedDate')) {
            $_newCompletedDate = ($completedDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'completedDate' -Value $_newCompletedDate
        }

        if ($PSBoundParameters.ContainsKey('closed')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closed' -Value $closed
        }

        if ($PSBoundParameters.ContainsKey('closedDate')) {
            $_newClosedDate = ($closedDate | ConvertTo-ISODate)
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closedDate' -Value $_newClosedDate
        }

        if ($PSBoundParameters.ContainsKey('closureCode')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'closureCode' -Value @{ 'id' = $closureCode }
        }

        if ($PSBoundParameters.ContainsKey('costs')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'costs' -Value $costs
        }

        if ($PSBoundParameters.ContainsKey('feedbackRating')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackRating' -Value $feedbackRating
        }

        if ($PSBoundParameters.ContainsKey('feedbackMessage')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'feedbackMessage' -Value $feedbackMessage
        }

        if ($PSBoundParameters.ContainsKey('optionalFields1')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $optionalFields1
        }

        if ($PSBoundParameters.ContainsKey('optionalFields2')) {
            Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'optionalFields1' -Value $optionalFields2
        }

        if (($PSBoundParameters.ContainsKey('externalLinkID')) -and ($PSBoundParameters.ContainsKey('externalLinkType'))) {
            if ($PSBoundParameters.ContainsKey('externalLinkDate')) {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType; 'date' = $externalLinkDate }
            }
            else {
                Add-Member -InputObject $newIncident -MemberType NoteProperty -Name 'externalLink' -Value @{ 'id' = $externalLinkID; 'type' = $externalLinkType }
            }
        }

        $_headerslist = @{ 'Content-Type' = 'application/json' }
        $_uri = $script:tdURI + '/tas/api/incidents/'
        $_body = (ConvertTo-Json -InputObject $newIncident -Depth 8 -Compress)

        if ($PSCmdlet.ShouldProcess( $_body, 'Create' )) {
            Get-APIResponse -Method 'POST' -APIurl $_uri -Body $_body -Headers $_headerslist -tdCredential $script:tdCredential
        }

    }

    end {

    }
}
