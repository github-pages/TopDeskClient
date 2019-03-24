function Get-AssetList
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
                SupportsShouldProcess=$true,
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/Docs/Get-AssetList.md',
                ConfirmImpact='Medium')]
    [OutputType([PSObject])]

    Param (
        # Template ID of type of asset to retrieve
        [Parameter(Mandatory = $true,
        ParameterSetName = 'Default',
        ValueFromPipelineByPropertyName = $true)]
        [string]
        $TemplateID,

        # List of fields to include for each asset
        [Parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $Fields,

        # Include archved assets?
        [Parameter(Mandatory = $false)]
        [switch]
        $Archive
    )

    begin {

        if (-not($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/templateId/' + $TemplateID

        if($PSBoundParameters.ContainsKey('Fields')) {
           
            #$_fieldlist = [string]::Join(",", $Fields)
            #$_fieldlist = ConvertTo-Json -InputObject $Fields -Compress

            #$_uri += '?'
            $i = 0
            foreach ($field in $Fields) {
                if($i -eq 0) {
                    $i++
                    $_uri += '?field=' + $field
                }
                else {
                    $_uri += '&field=' + $field
                }
            }
            #$_uri += '?field=' + $_fieldlist

        }

        if ($Archive) {

            if($_uri.Contains('?')) {
                $_uri += '&includeArchived=true'
            }
            else {
                $_uri += '?includeArchived=true'
            }

        }

        $_headerslist = @{
            'Content-Type' = 'application/json'
        }

    }

    process {

        Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

    }

    end {}
}
