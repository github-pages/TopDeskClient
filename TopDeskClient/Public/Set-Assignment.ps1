function Set-Assignment {

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

        [System.Management.Automation.PSCustomObject]

        Name            MemberType      Definition
        ---------------------------------------------------------
        Equals               Method            bool Equals(System.Object obj)
        GetHashCode   Method            int GetHashCode()
        GetType            Method            type GetType()
        ToString            Method            string ToString()
        linkErrors          NoteProperty   Object[] linkErrors=System.Object[]
        modified           NoteProperty   bool modified=False
        unlinkErrors      NoteProperty   Object[] unlinkErrors=System.Object[]

        Sample linkErrors object with errors
        {@{id=ef935e2c-f331-42bf-bbe9-8da872525de5; errorCode=value_unknown}}

    .NOTES

      Additional information about the function or script.

    .LINK

        [Set-Assignment](https://github.com/rbury/TopDeskClient/Docs/Set-Assignment.md)

  #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        SupportsShouldProcess = $true,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Set-Assignment.md',
        ConfirmImpact = 'Medium')]
        [OutputType([PSObject])]

    Param (

        # The id of the asset to assign to.
        [Parameter(Mandatory = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [Alias('unid')]
        [string]
        $AssetID,

        # The template id specifying the type of the asset.
        [Parameter(Mandatory = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [Alias('type_id')]
        [string]
        $TemplateID,

        # The id of the target to be assigned to.
        [Parameter(Mandatory = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [Alias('id')]
        [string[]]
        $TargetID,

        # Set target type to Branch
        [Parameter(Mandatory = $true,
        ParameterSetName = 'branches')]
        [switch]
        $Branch,

        # Set target type to Location
        [Parameter(Mandatory = $true,
        ParameterSetName = 'locations')]
        [switch]
        $Location,

        # Set target type to PersonGroup
        [Parameter(Mandatory = $true,
        ParameterSetName = 'persongroups')]
        [switch]
        $PersonGroup,

        # Set target type to Person
        [Parameter(Mandatory = $true,
        ParameterSetName = 'persons')]
        [Parameter(Mandatory = $false,
        ParameterSetName = 'Default')]
        [switch]
        $Person

    )

        #region initialize

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_uri = $script:tdURI + "/tas/api/assetmgmt/assets/templateId/$TemplateID/$AssetID/assignment/"
        $_headerstring = @{
            'Content-Type' = 'application/json'
        }

        #endregion

    #region hardwork

    switch ($PSCmdlet.ParameterSetName) {

        {($_ -eq 'persons') -or ($_ -eq 'Default')} {

            $_uri += 'persons'

                $_body = @{
                    'ids' = @(
                        $TargetID
                    )
                }

                $_body = ConvertTo-Json -InputObject $_body

                Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential;

                break

            }

        'branches' {

            $_uri += 'branches'

            $_body = @{
                'ids' = @(
                    $TargetID
                )
            }

            $_body = ConvertTo-Json -InputObject $_body

            Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential;

            break

        }

        'locations' {

            $_uri += 'locations'

            $_body = @{
                'ids' = @(
                    $TargetID
                )
            }

            $_body = ConvertTo-Json -InputObject $_body

            Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential

            break

        }

        'PersonGroups' {

            $_uri += 'personGroups'

            $_body = @{
                'ids' = @(
                    $TargetID
                )
            }

            $_body = ConvertTo-Json -InputObject $_body

            Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential

            break

        }

    }

    #endregion

    #region finalize

    #endregion
}