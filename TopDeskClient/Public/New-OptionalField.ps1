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
    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        HelpUri = 'https://github.com/rbury/TopDeskClient/Docs/New-OptionalFields.md',
        ConfirmImpact = 'Low')]
    [OutputType([hashtable], ParameterSetName = "Default")]

    Param (

        # OptionalFields to create ( 1 or 2 ) - Default 1
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber')]
        [ValidateSet(1,2)]
        [int]
        $optionalField = 1,

        # Boolean values in order (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [ValidateNotNullOrEmpty()]
        [bool[]]
        $boolean,

        # Boolean values assigned by number
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber' )]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $booleanHash,

        # Numeric values in order (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [float[]]
        $number,

        # Numeric values assigned by number
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber' )]
        [hashtable]
        $numberHash,

        # Date values in order (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [datetime[]]
        $date,

        # Date values assigned by number
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber' )]
        [hashtable]
        $DateHash,

        # Text values in order (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [string[]]
        $text,

        # Text values assigned by number
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber' )]
        [hashtable]
        $TextHash,

        # Memo values in order (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [string[]]
        $memo,

        # Memo values assigned by number
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber' )]
        [hashtable]
        $memoHash,

        # Searchlist values in order (1-5)
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Default' )]
        [string[]]
        $searchlist,

        # Searchlist values assigned by number
        [Parameter( Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byNumber' )]
        [hashtable]
        $searchlistHash

    )

    begin {

        #[System.Collections.ArrayList] $return = @{ }
        [System.Collections.Generic.List[hashtable]] $return = @{ }
        $boolcount = 0
        $numbercount = 0
        $datecount = 0
        $textcount = 0
        $memocount = 0
        $searchlistcount = 0

    }

    process {

        if ( $PSCmdlet.ParameterSetName -eq 'Default' ) {

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

            if ($PSBoundParameters.ContainsKey('memo')) {

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

        if ( $PSCmdlet.ParameterSetName -eq 'byNumber' ) {

            if ( $PSBoundParameters.ContainsKey('booleanHash') ) {

                $null = $return.Add( $booleanHash )

            }

            if ( $PSBoundParameters.ContainsKey('numberHash') ) {

                $null = $return.Add( $numberHash )

            }

            if ( $PSBoundParameters.ContainsKey('DateHash') ) {

                $null = $return.Add( $DateHash )

            }

            if ( $PSBoundParameters.ContainsKey('TextHash') ) {

                $null = $return.Add( $TextHash )

            }

            if ( $PSBoundParameters.ContainsKey('memoHash') ) {

                $null = $return.Add( $memoHash )

            }

            if ( $PSBoundParameters.ContainsKey('searchlistHash') ) {

                $null = $return.Add( $searchlistHash )

            }

        }

    }

    end {

        $returnhash = [hashtable] @{ }
        $_optionalFieldNum = 'optionalFields' + $optionalField
        $returnhash.Add($_optionalFieldNum, $return)
        return $returnhash

    }
}
