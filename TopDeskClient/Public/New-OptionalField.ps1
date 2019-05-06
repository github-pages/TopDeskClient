function New-OptionalField {
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
                HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/New-OptionalFields.md',
                ConfirmImpact='Low')]
    [OutputType([hashtable], ParameterSetName = "Default")]

    Param (

        # Boolean values (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [bool[]]
        $boolean,

        # Numeric values (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [float[]]
        $number,

        # Date values (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [datetime[]]
        $date,

        # Text values (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [string[]]
        $text,

        # Memo values (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [string[]]
        $memo,

        # Searchlist values (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [string[]]
        $searchlist
    )

    begin {
        [System.Collections.ArrayList] $return = @{}
        $boolcount = 0
        $numbercount = 0
        $datecount = 0
        $textcount = 0
        $memocount = 0
        $searchlistcount = 0
    }

    process {

        if ($PSBoundParameters.ContainsKey('boolean')) {
            foreach ($boolItem in $boolean) {
                $booleanName = 'boolean' + ( $boolcount + 1 )
                $null = $return.Add( @{ $booleanName = $boolItem } )
                $boolcount += 1
            }
        }

        if ($PSBoundParameters.ContainsKey('number')) {
            foreach ($numberItem in $number) {
                $numberName = 'number' + ( $numbercount + 1 )
                $null = $return.Add( @{ $numberName = $numberItem } )
                $numbercount += 1
            }
        }

        if ($PSBoundParameters.ContainsKey('date')) {
            foreach ($dateItem in $date) {
                $dateName = 'date' + ( $datecount + 1 )
                $newDate = ($dateItem | ConvertTo-ISODAte)
                $null = $return.Add( @{ $dateName = $dateItem } )
                $datecount += 1
            }
        }

        if ($PSBoundParameters.ContainsKey('text')) {
            foreach ($textItem in $text) {
                $textName = 'text' + ( $textcount + 1 )
                $null = $return.Add( @{ $textName = $textItem } )
                $textcount += 1
            }
        }

        if($PSBoundParameters.ContainsKey('memo')) {
            foreach ($memoItem in $memo) {
                $memoName = 'memo' + ( $memocount + 1 )
                $null = $return.Add( @{ $memoName = $memoItem } )
                $memocount += 1
            }
        }

        if ($PSBoundParameters.ContainsKey('searchlist')) {
            foreach ($searchlistItem in $searchlist) {
                $searchlistName = 'searchlist' + ( $searchlistcount + 1 )
                $null = $return.Add( @{ $searchlistName = $searchlistItem } )
                $searchlistcount += 1
            }
        }

       <#  if ( $PSBoundParameters.Count -gt 0 ) {

            foreach ( $item in $PSBoundParameters.GetEnumerator() ) {

                switch ( $item.Key ) {

                    'boolean' {
                        foreach( $boolitem in $boolean) {
                            $booleanName = 'boolean' + ( $boolcount + 1 )
                            $null = $return.Add( @{ $booleanName = $boolean[0] } )
                            $boolcount += 1
                            break
                        }
                    }

                    'number' {
                        $numerName = 'number' + ( $numercount + 1 )
                        $null = $return.Add( @{ $numberName = $number[0] } )
                        $numbercount += 1
                        break
                    }

                    'date' {
                        $dateName = 'date' + ( $datecount + 1 )
                        $newDate = ($date[$i-1] | ConvertTo-ISODAte)
                        $null = $return.Add( @{ $dateName = $date[0] } )
                        $datecount += 1
                        break
                    }

                    'text' {
                        $textName = 'text' + ( $textcount + 1 )
                        $null = $return.Add( @{ $textName = $text[0] } )
                        break
                    }

                    'memo' {
                        $memoName = 'memo' + ( $memocount + 1 )
                        $null = $return.Add( @{ $memoName = $memo[0] } )
                        break
                    }

                    'searchlist' {
                        $searchlistName = 'searchlist' + ( $searchlistcount + 1 )
                        $null = $return.Add( @{ $searchlistName = $searchlist[0] } )
                        break
                    }

                    Default {}
                }   
            }
        } #>

    }

    end {
        $returnhash = [hashtable] @{}
        $returnhash.Add('optionalFields1',$return)
        return $returnhash
    }
}
