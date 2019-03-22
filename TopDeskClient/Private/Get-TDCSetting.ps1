function Get-TDCSetting
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

        https://github.com/rbury/TopDeskClient/Docs

#>
    [CmdletBinding(DefaultParameterSetName='Default',
                PositionalBinding=$false,
                ConfirmImpact='Medium')]
    [OutputType([NullString])]

    Param(

        # URL for TopDesk Instance
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Default',
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('url')]
        [string]
        $tdURI

    )

    begin {

      $_instance = $tdURI.Replace("https://","")
      $_settingPath = "$env:APPDATA\TopDeskClient\$_instance\settings.bin"

    }

    process
    {

        if(Test-Path -Path "$_settingPath" -PathType Leaf) {

            $_mySettings = Import-Object -FilePath $_settingPath
            $script:tdURI = $_mySettings.URI
            $script:tdCredential = New-Object -TypeName pscredential -ArgumentList @($_mySettings.CRD[0],($_mySettings.CRD[1]|ConvertTo-SecureString))

      }
    }

    end {}
}