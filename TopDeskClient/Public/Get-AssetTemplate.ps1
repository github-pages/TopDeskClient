function Get-AssetTemplate
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
                PositionalBinding=$false,
                HelpUri = 'https://github.com/rbury/Docs/Get-AssetTemplate.md',
                ConfirmImpact='Medium')]
    [OutputType([PSObject])]

    Param ()

    begin {
        
        if (-not($script:tdConnected)) {

            $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

        }

        $_headerslist = @{
            'Content-Type' = 'application/json'
        }

        $_uri = $script:tdURI + '/tas/api/assetmgmt/cardTypes/'
    }

    process {

        Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers $_headerslist -tdCredential $script:tdCredential

    }

    end {}
}