function Add-Assignment {
    
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
    
        [Set-Assignment](https://github.com/rbury/TopDeskClient/Docs/Add-Assignment.md)
  #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Add-Assignment.md',
        ConfirmImpact = 'Medium')]
    [OutputType([PSObject])]

    Param (

        # The id of the asset being assigned to.
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('unid')]
        [string[]]
        $AssetID,
        
        # ID of target to assign.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Default',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [string]
        $TargetID,

        # Type of the target, one of branch, person, personGroup, incident
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Default',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('branch', 'person', 'personGroup', 'incident')]
        [string]
        $TargetType,

        # Assign to a location
        [Parameter(Mandatory = $true,
            ParameterSetName = 'location',
            ValueFromPipelineByPropertyName = $true)]
            [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $LocationID,

        # Branch ID
        [Parameter(Mandatory = $true,
            ParameterSetName = 'location',
            ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')]
        [string]
        $BranchID

    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/assignments/'
        $_headerstring = @{
            'Content-Type' = 'application/json'
        }

    }

    process {

        if ($PSBoundParameters.ContainsKey('Force') -or ($PSCmdlet.ShouldProcess("Assign asset to id: $TargetID", 'Assign this Asset?', 'Assign asset'))) {

            switch ($PSCmdlet.ParameterSetName) {

                'Default' {

                    foreach ($_assetID in $AssetID) {

                        $_body = @{
                            'assetIds' = @(
                                $_assetID
                            )
                            'linkType' = $TargetType
                            'linkToId' = $TargetID
                        }

                        $_body = ConvertTo-Json -InputObject $_body

                        Write-Verbose -Message ("Setting assignment with body {0}" -f $_body)

                        Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential;

                        break

                    }
                }

                'location' {

                    foreach ($_assetID in $AssetID) {

                        $_body = @{
                            asssetIds = @(
                                $_assetID
                            )
                            linkType  = 'location'
                            linkToId  = $LocationID
                            branchId  = $BranchID
                        }
                        Get-APIResponse -Method 'PUT' -APIUrl $_uri -Body $_body -Headers $_headerstring -tdCredential $script:tdCredential;
                        break

                    }
                }
            }
        }

    }

    end {

    }

}
