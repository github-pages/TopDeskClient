function Get-Branch {
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


#>
    [CmdletBinding(DefaultParameterSetName = 'Details',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Branch.md',
        ConfirmImpact = 'Medium')]

    Param (

        # Name of branch to retrieve details for
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Details',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('id', 'unid')]
        [string[]]
        $BranchID,

        # Get list of branches
        [Parameter(Mandatory = $true,
            ParameterSetName = 'List')]
        [switch]
        $List,

        # Branch Name
        [Parameter(Mandatory = $true,
            ParameterSetName = 'BranchName',
            ValueFromPipelineByPropertyName = $true)]
        [Alias('name')]
        [string]
        $BranchName

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
    }

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'List' {

                $_uri = $Script:tdURI + '/tas/api/branches'
                $_headerslist = @{
                    'Content-Type' = 'application/json';
                }

                Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

            }

            'Details' {

                foreach ($_branch in $BranchID) {

                    if ($_branch -ne '') {

                        $_uri = $Script:tdURI + '/tas/api/branches/id/' + $_branch
                        $_headerslist = @{
                            'Content-Type' = 'application/json';
                        }

                        Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                    }
                }
            }

            'BranchName' {

                $_uri = $Script:tdURI + '/tas/api/branches?nameFragment=' + $BranchName.Trim()
                $_headerslist = @{
                    'Content-Type' = 'application/json';
                }

                Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

            }

        }
    }

    end { }
}