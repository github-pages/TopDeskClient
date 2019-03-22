function Get-Incident {
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

        [Get-Incident](https://github.com/rbury/TopDeskClient/Docs/Get-Incident.md)

  #>
    [CmdletBinding(DefaultParameterSetName='Number',
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/Get-Incident.md',
                ConfirmImpact='Medium')]
    [OutputType([PSObject], ParameterSetName = "Number")]

    Param (

        # Incident number
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'Number')]
        [ValidateNotNullOrEmpty()]
        [Alias('id','IncidentNumber')]
        [string]
        $Number,

        # Asset Name
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true,
        ParameterSetName = 'ByAssetName')]
        [ValidateNotNullOrEmpty()]
        [Alias('AssetID','name')]
        [string]
        $AssetName

    )

    begin{

        if (!($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_headerslist = @{
            'Content-Type' = 'application/json'
        }

    }
    
    process {

        switch ($PSCmdlet.ParameterSetName) {

            'Number' {

                $_uri = $script:tdURI + '/tas/api/incidents/number/' + $Number.Trim()
                
                Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                break

            }

            'ByAssetName' {

                $_uri = $script:tdURI + '/tas/api/incidents?object_name=' + $AssetName.Trim()

                Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

                break

            }
        }
    }

    end {}

}
