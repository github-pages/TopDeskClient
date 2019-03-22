function Get-Person {
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

        [Get-Person](https://github.com/rbury/TopDeskClient/Docs/Get-Person.md)

  #>
    [CmdletBinding(DefaultParameterSetName = 'Simple',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-Person.md',
        ConfirmImpact = 'Medium')]

    Param (

        # ID of person to retrieve
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Simple',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('unid','ID')]
        [string[]]
        $PersonID,

        # Get a list of all persons
        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [switch]
        $List,

        # SSP login name to lookup for person
        [Parameter(Mandatory = $true,
            ParameterSetName = 'BySSP',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $SSPLoginName,

        # Network login name to lookup for person
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ByNetworkLogin',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $NetworkLoginName,

        # Email address to lookup for person
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ByEmail',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Email,

        # Last name to lookup for person
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ByLastName',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $LastName,

        # First name to lookup for person
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ByFirstName',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $FirstName,

        # Include archived records?
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [bool]
        $Archived = $false

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
    }

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'List' {

                $_uri = $script:tdURI + '/tas/api/persons/lookup?$all=true'

                if ($PSBoundParameters.ContainsKey('Archived')) {

                    $_uri += '&archived=$false'

                }

                $_headerslist = @{
                    'Content-Type' = 'application/json'
                }
                Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential
                break
            }

            'Details' {

                foreach ($_person in $PersonID) {

                    $_uri = $script:tdURI + '/tas/api/persons/id/' + $_person

                    if ($Archived) {

                        $_uri += '&archived=$true'

                    }

                    $_headerslist = @{
                        'Content-Type' = 'application/json'
                    }
                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break
            }

            'BySSP' {

                foreach ($SSPLogin in $SSPLoginName) {

                    $_uri = $script:tdURI + '/tas/api/persons?ssp_login_name=' + $SSPLogin

                    if ($Archived) {

                        $_uri += '&archived=$true'

                    }

                    $_headerslist = @{
                        'Content-Type' = 'application/json'
                    }

                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break
            }

            'ByNetworkLogin' {

                foreach ($NetworkLogin in $NetworkLoginName) {

                    $_uri = $script:tdURI + '/tas/api/persons?network_login_name=' + $NetworkLogin

                    if ($Archived) {

                        $_uri += '&archived=$true'

                    }

                    $_headerslist = @{
                        'Content-Type' = 'application/json'
                    }

                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break

            }

            'ByEmail' {

                foreach ($PersonEmail in $Email) {

                    $_uri = $script:tdURI + '/tas/api/persons?email=' + $PersonEmail

                    if ($Archived) {

                        $_uri += '&archived=$true'

                    }

                    $_headerslist = @{
                        'Content-Type' = 'application/json'
                    }

                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break

            }

            'ByLastName' {

                foreach ($PersonLN in $LastName) {

                    $_uri = $script:tdURI + '/tas/api/persons?lastname=' + $PersonLN

                    if ($Archived) {

                        $_uri += '&archived=$true'

                    }

                    $_headerslist = @{
                        'Content-Type' = 'application/json'
                    }

                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break

            }

            'ByFirstName' {

                foreach ($PersonFN in $FirstName) {

                    $_uri = $script:tdURI + '/tas/api/persons?firstname=' + $PersonFN

                    if ($Archived) {

                        $_uri += '&archived=$true'

                    }

                    $_headerslist = @{
                        'Content-Type' = 'application/json'
                    }

                    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                }

                break

            }
        }
    }

    end {}

}