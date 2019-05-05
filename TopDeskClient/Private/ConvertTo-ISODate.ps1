function ConvertTo-ISODate {
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
                HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/ConvertTo-ISODate.md',
                ConfirmImpact='Medium')]
    [OutputType([String], ParameterSetName = "Default")]

    Param (
        # Datetime object to convert to ISO 8601 format
        [Parameter(Mandatory = $true,
        ParameterSetName = 'Default',
        ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [datetime]
        $Date
    )

    begin {

    }

    process {
        foreach ($item in $Date) {
            return [string] ($item.ToString('o').SubString(0,23) + $item.ToString('zzz').Replace(':',''))
        }
    }

    end {

    }
}
