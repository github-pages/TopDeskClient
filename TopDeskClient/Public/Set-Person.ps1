function Set-Person
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
    [CmdletBinding(DefaultParameterSetName='Default',
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/',
                ConfirmImpact='Medium')]
    [OutputType([psobject], ParameterSetName = "Default")]
    Param (

        # ID of person to modify
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string[]]
        $PersonID,

        # LastName of person
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,50)]
        [string[]]
        $surName,

        # FirstName of person
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,30)]
        [string[]]
        $firstName,

        # Person initials
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,10)]
        [string[]]
        $firstInitials,

        # Person prefix
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,10)]
        [string[]]
        $prefixes,

        # Person gender
        [Parameter(Mandatory = $false)]
        [ValidateSet('UNDEFINED','MALE','FEMALE')]
        [string[]]
        $gender,

        # Person employee number
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,20)]
        [string[]]
        $employeeNumber,

        # Network login name
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,100)]
        [string[]]
        $networkLoginName,

        # Branch
        [Parameter(Mandatory = $false)]
        [string[]]
        $branch,

        # Location
        [Parameter(Mandatory = $false)]
        [string[]]
        $location,

        # Department
        [Parameter(Mandatory = $false)]
        [string[]]
        $department,

        # Language
        [Parameter(Mandatory = $false)]
        [string[]]
        $language,

        # Department (only when set to text field)
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,60)]
        [string[]]
        $departmentFree,

        # Person login name
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,100)]
        [string[]]
        $tasLoginName,

        # Person password (5-200 characters)
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [securestring[]]
        $password,

        # phone number
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,25)]
        [string[]]
        $phoneNumber,

        # Mobile number
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,25)]
        [string[]]
        $mobileNumber,

        # Fax
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,25)]
        [string[]]
        $fax,

        # Email address
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,100)]
        [string[]]
        $email,

        # Job Title
        [Parameter(Mandatory = $false)]
        [ValidateLength(1,100)]
        [string[]]
        $jobTitle,

        # View all requests under own budget holder
        [Parameter(Mandatory = $false)]
        [bool[]]
        $showBudgetholder,

        # View all requests under own department
        [Parameter(Mandatory = $false)]
        [bool[]]
        $showDepartment,

        # View all requests under own branch
        [Parameter(Mandatory = $false)]
        [bool[]]
        $showBranch,

        # View all requests under own sub-branch (requires showBranch = $true)
        [Parameter(Mandatory = $false)]
        [bool[]]
        $showSubsidiaries,

        # Access all branches on forms
        [Parameter(Mandatory = $false)]
        [bool[]]
        $showAllBranches,

        # Authorize requests for own department/budgetholder/branch/subsidury (requires Manager = $true)
        [Parameter(Mandatory = $false)]
        [bool[]]
        $authorizeAll,

        # Authorize requests for own department (requires Manager = $true)
        [Parameter(Mandatory = $false)]
        [bool[]]
        $authorizeDepartment,

        # Authorize requests for own budget holder (requires Manager = $true)
        [Parameter(Mandatory = $false)]
        [bool[]]
        $authorizeBudgetHolder,

        # Authorize requests for own branch (requires Manager = $true)
        [Parameter(Mandatory = $false)]
        [bool[]]
        $authorizeBranch,

        # Authorize requests for subsidury locations (requires Manager & Branch = $true)
        [Parameter(Mandatory = $false)]
        [bool[]]
        $authorizeSubsidiaryBranches,

        # Optional fields 1
        [Parameter(Mandatory = $false)]
        [psobject[]]
        $optionalFields1,

        # Optional fields 2
        [Parameter(Mandatory = $false)]
        [psobject[]]
        $optionalFields2,

        # Budget Holder
        [Parameter(Mandatory = $false)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string[]]
        $budgetHolder,

        # Extra field A
        [Parameter(Mandatory = $false)]
        [string[]]
        $personExtraFieldA,

        # Extra field B
        [Parameter(Mandatory = $false)]
        [string[]]
        $personExtraFieldB,

        # Person is a Manager
        [Parameter(Mandatory = $false)]
        [bool[]]
        $isManager,

        # Manager
        [Parameter(Mandatory = $false)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string[]]
        $manager
    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

    }
    
    process {

        foreach ($person in $PersonID) {
            #$pid = $person
            $persontoset = [PSCustomObject]@{
                unid = $person
            }
            for ($i = 0; $i -lt $psboundParameters.Count; $i++) {
                if($psboundParameters[$i] -eq 'PersonID') { continue }

                $persontoset.$psboundParameters[$i].key = $psboundParameters[$i].value

            }

            Write-Output ("person: {0}" -f $persontoset)
            Write-Output ("Person-json: {0}" -f $persontoset)
        }
    }
    
    end {

    }
}
