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
    [CmdletBinding(PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/',
                SupportsShouldProcess = $true,
                ConfirmImpact='Medium')]
    [OutputType([psobject])]
    Param (

        # ID of person to modify
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [Alias('id')]
        [string]
        $PersonID,

        # LastName of person
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,50)]
        [Alias('LastName')]
        [string]
        $surName,

        # FirstName of person
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,30)]
        [Alias('Name','GivenName')]
        [string]
        $firstName,

        # Person initials
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,10)]
        [string]
        $firstInitials,

        # Person prefix
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,10)]
        [string]
        $prefixes,

        # Person gender
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('UNDEFINED','MALE','FEMALE')]
        [string]
        $gender,

        # Person employee number
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,20)]
        [Alias('EmployeeID')]
        [string]
        $employeeNumber,

        # Network login name
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,100)]
        [Alias('username')]
        [string]
        $networkLoginName,

        # Branch
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [string]
        $branch,

        # Location
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [string]
        $location,

        # Department
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [Alias('dept')]
        [string]
        $department,

        # Language
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [Alias('lang')]
        [string]
        $language,

        # Department (only when set to text field)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,60)]
        [string]
        $departmentFree,

        # Person login name
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,100)]
        [Alias('Login')]
        [string]
        $tasLoginName,

        # Person password (5-200 characters)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $password,

        # phone number
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,25)]
        [Alias('Phone')]
        [string]
        $phoneNumber,

        # Mobile number
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,25)]
        [Alias('cell','mobile')]
        [string]
        $mobileNumber,

        # Fax
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName)]
        [ValidateLength(1,25)]
        [string]
        $fax,

        # Email address
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,100)]
        [string]
        $email,

        # Job Title
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateLength(1,100)]
        [string]
        $jobTitle,

        # View all requests under own budget holder
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $showBudgetholder,

        # View all requests under own department
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $showDepartment,

        # View all requests under own branch
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $showBranch,

        # View all requests under own sub-branch (requires showBranch = $true)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $showSubsidiaries,

        # Access all branches on forms
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $showAllBranches,

        # Authorize requests for own department/budgetholder/branch/subsidury (requires Manager = $true)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $authorizeAll,

        # Authorize requests for own department (requires Manager = $true)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $authorizeDepartment,

        # Authorize requests for own budget holder (requires Manager = $true)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $authorizeBudgetHolder,

        # Authorize requests for own branch (requires Manager = $true)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $authorizeBranch,

        # Authorize requests for subsidury locations (requires Manager & Branch = $true)
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $authorizeSubsidiaryBranches,

        # Optional fields 1
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [psobject]
        $optionalFields1,

        # Optional fields 2
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [psobject]
        $optionalFields2,

        # Budget Holder
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $budgetHolder,

        # Extra field A
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [hashtable]
        $personExtraFieldA,

        # Extra field B
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [hashtable]
        $personExtraFieldB,

        # Person is a Manager
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [bool]
        $isManager,

        # Manager
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $manager

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_headerstring = @{
            'Content-Type' = 'application/json'
        }

    }
    
    process {

        foreach ($person in $PersonID) {

            if ($PSBoundParameters.ContainsKey('Force') -or ($PSCmdlet.ShouldProcess('Modify Person', 'Modify this person in TopDesk?', "Modify person in TopDesk [id: $person]"))) {
                if($psboundParameters.Keys.Count -gt 1) {

                    $_uri = $script:TDURI + '/tas/api/persons/id/' + $person
                    $persontoset = [PSCustomObject]@{}

                    foreach ($item in $psboundParameters.GetEnumerator()) {

                        if($item.key -eq 'PersonID') { continue }
                        if($null -ne $item.value) {
                            $persontoset | Add-Member -MemberType NoteProperty -Name $item.key -Value $item.value
                        }
                    }

                    $_body = ($persontoset | ConvertTo-Json)
                    Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential;
                }
            }
        }
    }
    
    end {

    }
}
