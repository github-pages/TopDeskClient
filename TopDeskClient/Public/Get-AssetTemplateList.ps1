function Get-AssetTemplateList {
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

    [Get-AssetTemplate](https://github.com/rbury/TopDeskClient/Docs/Get-AssetTemplate.md)

  #>
    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-AssetTemplateList.md',
        ConfirmImpact = 'Medium')]

    Param ()

    begin {

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }
    }

    process {

        if ($script:tdConnected) {

            $_uri = $script:tdURI + '/tas/api/assetmgmt/templates'

            Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

            #$_all_Templates = Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json'} -tdCredential $script:tdCredential

            <# if (($null -ne $_all_Templates) -and ($_all_Templates | Get-Member).Name -icontains 'dataSet') {

                foreach ($template in $_all_Templates.dataSet) {

                    #$_returnval.Add($template)
                    return $template

                }

            }
            else {

                if ($null -ne $_all_Templates) {

                    Write-Error ("Problem retrieving templates {0}" -f $_all_Templates)

                }
                else {

                    Write-Error ("Problem retrieving templates")

                }
            } #>

        }
        else {

            Write-Warning ("TopDeskClient has not been connected, try using Connect-TopDesk first.")

        }

    }

    end {}
}