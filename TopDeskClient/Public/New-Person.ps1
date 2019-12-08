function New-Person {
  <#
    .Synopsis

      Create a person in TopDesk

    .DESCRIPTION

      This function will create a new person in TopDesk, accepting most fields to be set upon creation.

    .EXAMPLE

      New-Person -LastName 'Smith' -FirstName 'John'

      Create a new person named John Smith.

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      [PSCustomObject]

    .NOTES

      Additional information about the function or script.

    .LINK

      https://github.com/rbury/TopDeskClient/blob/master/Docs/New-Person.md
  #>

  [CmdletBinding(DefaultParameterSetName = 'Default',
    SupportsShouldProcess = $true,
    PositionalBinding = $false,
    HelpUri = "https://github.com/rbury/TopDeskClient/blob/master/Docs/New-Person.md",
    ConfirmImpact = 'Medium')]
  [OutputType([PSCustomObject], ParameterSetName = "Default")]

  Param (
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 50)]
    [string]
    $surName,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 30)]
    [string]
    $firstName,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 10)]
    [string]
    $firstInitials,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 10)]
    [string]
    $prefixes,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 100)]
    [string]
    $birthName,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateSet('UNDEFINED', 'MALE', 'FEMALE')]
    [string]
    $gender,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 20)]
    [string]
    $employeeNumber,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 100)]
    [string]
    $networkLoginName,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $branch,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $location,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $department,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $language,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 60)]
    [string]
    $departmentFree,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 100)]
    [string]
    $tasLoginName,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [securestring]
    $password,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 25)]
    [string]
    $phoneNumber,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 25)]
    [string]
    $mobileNumber,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 25)]
    [string]
    $fax,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 100)]
    [string]
    $email,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 100)]
    [string]
    $jobTitle,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $showBudgetHolder,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $showDepartment,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $showBranch,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $showSubsidiaries,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $showAllBranches,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $authorizeAll,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $authorizeDepartment,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $authorizeBudgetHolder,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $authorizeBranch,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $authorizeSubsidiaryBranches,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $budgetHolder,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $personExtraFieldA,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $personExtraFieldB,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [Boolean]
    $isManager,

    [Parameter(Mandatory = $false,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
    [string]
    $manager
  )

  begin {
    if (!($script:tdConnected)) {
      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::ConnectionError, $null))
    }
  }

  process {
    $person = [PSCustomObject]@{ }

    foreach ($p in $psboundparameters.Keys) {
      if ($P -inotin 'password','Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable', 'WhatIf', 'Confirm') {
        $null = Add-Member -InputObject $person -MemberType NoteProperty -Name $p -Value $psboundparameters.$p
      } elseif ($p -eq 'password') {
        $null = Add-Member -InputObject $person -MemberType NoteProperty -Name $p -Value [string]([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)))
      }
    }

    $_headerslist = @{ 'Content-Type' = 'application/json' }
    $_uri = $script:tdURI + '/tas/api/persons/'
    $_body = (ConvertTo-Json -InputObject $person -Depth 8 -Compress)
    if ($PSCmdlet.ShouldProcess("Person - $($surName)", "Create")) {
      Write-Verbose ("Calling {0} with {1}" -f $_uri, $_body)
      Get-APIResponse -Method 'POST' -APIurl $_uri -Body $_body -Headers $_headerslist -tdCredential $script:tdCredential
    }
  }

  end {

  }
}
