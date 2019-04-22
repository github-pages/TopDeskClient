function Get-Asset {
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

      Get-Asset (https://github.com/rbury/TopDeskClient/Docs/Get-Asset.md)
  #>
    [CmdletBinding(DefaultParameterSetName = 'AllAssets',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-Asset.md',
        ConfirmImpact = 'Medium')]
    [OutputType([System.Collections.ArrayList])]

    Param (

        # Asset type to retrieve
        [Parameter(Mandatory = $true,
            ParameterSetName = 'AllAssets',
            ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ArchivedAssets',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $AssetType,

        # limit to operational status
        [Parameter(Mandatory = $false,
            ParameterSetName = 'AllAssets',
            ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $false,
            ParameterSetName = 'ArchivedAssets',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Operational', 'Impacted')]
        [string]
        [Alias('Status')]
        $OperationalStatus,

        # Limit to active only
        [Parameter(Mandatory = $false,
            ParameterSetName = 'AllAssets')]
        [switch]
        $ActiveOnly,

        # Limit to archived only
        [Parameter(Mandatory = $false,
            ParameterSetName = 'ArchivedAssets')]
        [switch]
        $ArchivedOnly,

        # Fields to retrieve
        [Parameter(Mandatory = $false,
            Position = 1,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateCount(0, 500)]
        [string[]]
        $AssetFields,

        # Exclude Assignments?
        [Parameter(Mandatory = $false)]
        [switch]
        $NoAssignments,

        # Search by name
        [Parameter(Mandatory = $true,
            ParameterSetName = 'NameSearch',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        # Free text search
        [Parameter(Mandatory = $true,
            ParameterSetName = 'FreeText',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $SearchString,

        # List of linked ids
        [Parameter(Mandatory = $true,
            ParameterSetName = 'LinkSearch',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateCount(1, 100)]
        [Alias('Links')]
        [hashtable]
        $LinkList,

        # Filter string (limited simple odata filter)
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Filter',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Filter
    )

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        [System.Collections.ArrayList] $_returnval = [System.Collections.ArrayList]::new()

    }
    
    process {

        if ($PSBoundParameters.ContainsKey("AssetFields")) {

            $_fieldlist = [string]::Join(",", $AssetFields)

        }
        else {

            $_fieldlist = '';

        }
        switch ($pscmdlet.ParameterSetName) {

            'AllAssets' {

                if ($_fieldlist -ne '') {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?templateName=' + $AssetType + '&fields=' + $_fieldList

                }
                else {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?templateName=' + $AssetType + '&fields=name'

                }

                if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

                    $_uri += '&showAssignments=$true'

                }

                if ($PSBoundParameters.ContainsKey('ArchivedOnly')) {

                    $_uri += '&archived=$true'

                }
                elseif ($PSBoundParameters.ContainsKey('ActiveOnly')) {

                    $_uri += '&archived=$false'

                }

                if ($PSBoundParameters.ContainsKey('OperationalStatus')) {

                    $_uri += '&assetStatus=' + $OperationalStatus

                }

                $_all_Devices = Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

                if (($null -ne $_all_Devices) -and (($_all_Devices | Get-Member).Name -icontains 'dataSet')) {

                    foreach ($asset in $_all_Devices.dataSet) {

                        $null = $_returnval.Add($asset)

                    }

                    if ($_all_Devices.dataSet.Count -eq 50) {

                        Write-Debug ("last device {0}" -f $_all_Devices.dataSet[49])
                        $_lastDevice = $_all_Devices.dataSet[49].name
                        $complete = $false

                    }
                    else {

                        $complete = $true

                    }

                    while ($complete -ne $true) {

                        if ($_fieldlist -ne '') {

                            $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?$filter=name gt ' + $_lastDevice + '&templateName=' + $AssetType + '&fields=' + $_fieldList

                        }
                        else {

                            $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?$filter=name gt ' + $_lastDevice + '&templateName=' + $AssetType + '&fields=name'

                        }
                        if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

                            $_uri += '&showAssignments=$true'

                        }

                        if ($PSBoundParameters.ContainsKey('OperationalStatus')) {

                            $_uri += '&assetStatus=' + $OperationalStatus

                        }

                        $_all_Devices = Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

                        if (($null -ne $_all_Devices) -and (($_all_Devices | Get-Member).Name -icontains 'dataSet')) {

                            foreach ($asset in $_all_Devices.dataSet) {

                                $null = $_returnval.Add($asset)

                            }

                            if ($_all_Devices.dataSet.Count -eq 50) {

                                Write-Debug ("last device {0}" -f $_all_Devices.dataSet[49])
                                $_lastDevice = $_all_Devices.dataSet[49].name
                                $complete = $false

                            }
                            else {

                                $complete = $true

                            }
                        }
                        else {

                            $complete = $true

                            if ($null -ne $_all_Devices) {

                                Write-Error ("Problem retrieving assets {0}" -f $_all_Devices)

                            }
                            else {

                                Write-Error ("Problem retrieving assets with uri {0}" -f $_uri)

                            }
                        }
                    } # END while $complete -ne $true
                }
                else {

                    $complete = $true

                    if ($null -ne $_all_Devices) {

                        Write-Error ("Problem retreiving assets {0}" -f $_all_Devices)

                    }
                    else {

                        Write-Error ("Problem retrieving assets with uri {0}" -f $_uri)

                    }
                }
            }
            'NameSearch' {

                if ($_fieldlist -ne '') {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?nameFragment=' + $Name + '&fields=' + $_fieldList

                }
                else {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?nameFragment=' + $Name + '&fields=name'

                }

                if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

                    $_uri += '&showAssignments=$true'

                }
                Write-Verbose $_uri
                $null = $_returnval.Add((Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential))
            }

            'FreeText' {

                if ($_fieldlist -ne '') {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?searchTerm=' + $SearchString + '&fields=' + $_fieldList

                }
                else {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?searchTerm=' + $SearchString + '&fields=name'

                }

                if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

                    $_uri += '&showAssignments=$true'

                }

                Write-Verbose $_uri

                $null = $_returnval.Add((Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential))

            }

            'LinkSearch' {

                [System.Collections.ArrayList] $linkSearch = [System.Collections.ArrayList]::new()

                foreach ($link in $LinkList.GetEnumerator()) {

                    $null = $linkSearch.Add("$($link.key)/$($link.value)")

                }

                $linkSearch = $linkSearch.ToArray()

                if ($_fieldlist -ne '') {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?linkedTo=' + $linkSearch + '&fields=' + $_fieldList

                }
                else {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?linkedTo=' + $linkSearch + '&fields=name'

                }

                if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

                    $_uri += '&showAssignments=$true'

                }

                $null = $_returnval.Add((Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential))
            }

            'Filter' {

                if ($_fieldlist -ne '') {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?$filter=' + $Filter + '&fields=' + $_fieldList

                }
                else {

                    $_uri = $script:tdURI + '/tas/api/assetmgmt/assets?$filter=' + $Filter + '&fields=name'

                }

                if (!($PSBoundParameters.ContainsKey('NoAssignments'))) {

                    $_uri += '&showAssignments=$true'

                }

                $null = $_returnval.Add((Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential))

            }

            Default {}

        }
    }

    end {

        return $_returnval

    }
}