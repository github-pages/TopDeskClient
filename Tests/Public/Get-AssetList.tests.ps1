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
                HelpUri = 'https://github.com/rbury/',
                ConfirmImpact='Medium')]
    [OutputType([String], ParameterSetName = "Default")]
    Param
    (

    )
    begin
    {

    }
    process
    {

    }
    end
    {

    }
}
