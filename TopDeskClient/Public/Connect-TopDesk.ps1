function Connect-TopDesk {
    <#
    .Synopsis

        Connect to a TopDesk instance

    .DESCRIPTION

        The Connect-TopDesk  function initializes a connection to an TopDesk instance. A connection must be initialized before running any functions that communicate with Topdesk.

        By default, Connect-TopDesk will not persist connection information requiring the URI and authentication to be provided on each run. The Save parameter is provided to persist this information for the current user on the current computer. Each subsequent run will require the TopDesk instance URI to identify the instance and optionallly the -load parameter to use saved instance information.

    .PARAMETER TopDeskURI

        Supply the URI of the TopDesk instance.
        This is typically in the format https://mycompany.topdesk.net.

    .PARAMETER Save

        Include the Save parameter to have the TopDeskClient remember the connection details for this instance.

        Note: Saving the connection details applies to the current user on the current computer and is identified by the URI.
        If initializing a connection to save the connection details for automation, run the TopDeskClient as the same user account that will run the automation on the automation machine.

    .PARAMETER Load

        Include the Load parameter with the instance TopDeskURI to instruct the TopDeskClient to load previously saved information for this instance that was saved with the Save parameter.

        Note: Using the load parameter with out first using the Save parameter will effectivley be the same as omitting this parameter.

    .EXAMPLE

        Connect-TopDesk -TopDeskURI 'https://contoso.topdesk.net'

        This command will connect to the instance at https://contoso.topdesk.net and prompt to provide a username and password that have access to this tenant.

    .EXAMPLE

        Connect-TopDesk -TopDeskURI 'https://contoso.topdesk.net' -Save

        This command will connect to the instance at https://contoso.topdesk.net, prompt to provide a username and password that that have access to this tenant. If the connection is successful, this will be saved for the current user on this computer for future connections.

    .EXAMPLE

        Connect-TopDesk -TopDeskURI 'https://contoso.topdesk.net' -Load

        This command will connect to the instance at https://contoso.topdesk.net and attempt to authenticate using the previously saved information when run with the -Save parameter. If the connection is not successful, you will recieve a prompt requesting an authorized username and password to connect with this tenant.

    .INPUTS

        This function does not accept pipeline input

    .OUTPUTS

        [System.Boolean]
        Return value reflects the connection state of the client.

    .NOTES

        The load and save parameters are only applicable to the computer and user running the script. Using Connect-TopDesk with the save parameter as User 1 on computer 1, will have no effect on User 2. Likewise User 1 copying thier profile to computer 2 will require User 1 to use Connect-TopDesk with the save parameter on computer 2.

    .LINK

        https://github.com/rbury/TopDeskClient/blob/master/Docs/Disconnect-TopDesk.md

#>

    [CmdletBinding(DefaultParameterSetName = 'DefaultConnect',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Connect-TopDesk.md',
        ConfirmImpact = 'Medium')]
    [OutputType([bool])]

    Param
    (
        # URI for TopDesk tenant
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'DefaultConnect')]
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'save')]
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'load')]
        [ValidateNotNullOrEmpty()]
        [Alias('uri', 'url')]
        [string]
        $TopDeskURI,

        # Save connection details?
        [Parameter(Mandatory = $true,
            ParameterSetName = 'save')]
        [switch]
        $Save,

        # Load existing connection details?
        [Parameter(Mandatory = $true,
            ParameterSetName = 'load')]
        [switch]
        $Load
    )

    try {

        if ([regex]::Match($TopDeskURI, "(^https)(:\/\/)([^\s,]+)").success) {

            if ($PSBoundParameters.ContainsKey('Load')) {
                Get-TDCSetting -tdURI $TopDeskURI
            }

            if ($script:tdCredential -eq [pscredential]::Empty) {
                $script:tdCredential = Get-tdCredentail;
            }

            $script:tdConnected = $false;
            $script:tdAPIVersion = 0;
            $headers = @{'Content-Type' = 'application/json' }
            $uri = $TopDeskURI + '/tas/api/version'
            $script:tdAPIVersion = (Get-APIResponse -Method 'GET' -url $uri -Headers $headers -tdCredential $script:tdCredential)
            if ($null -ne ($script:tdAPIVersion | Get-Member -Name version)) {
                $script:tdConnected = $true;
            }
            else {
                $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("TopDesk instance not found at provided URL.", $null, [System.Management.Automation.ErrorCategory]::ObjectNotFound, $null))
            }
            $script:tdURI = $TopDeskURI.Trim('/')

            if ($PSBoundParameters.ContainsKey('Save')) {
                Save-TDCSetting;
            }

        }
        else {

            Write-Error ("Please verify the URL provided is correct - {0}" -f $TopDeskURI)

        }

    }
    catch {

        Write-Warning ("Problem connecting to TopDesk tenant with URL - {0}" -f $TopDeskURI)
        Write-Error ("Error: {0}" -f $_.Exception.Message)
        Write-Debug ("Stack: {0}" -f $_.ScriptStackTrace)
        return $false

    }

    return $script:tdConnected

}