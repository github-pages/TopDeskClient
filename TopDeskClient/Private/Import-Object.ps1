function Import-Object {

    [CmdletBinding(DefaultParameterSetName = 'Default',
        PositionalBinding = $false,
        ConfirmImpact = 'Medium')]
    [OutputType([PSObject])]

    Param
    (

        # Specify the path to the import file
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Default',
            ValueFromPipelineByPropertyName = $true)]
        [Alias('Path')]
        [ValidateScript( {Test-Path -Path $_ -PathType leaf})]
        [string]
        $FilePath,

        # Specify a literal path to the import file.
        [Parameter(Mandatory = $true,
            ParameterSetName = "LiteralPath",
            ValueFromPipelineByPropertyName = $true)]
        [Alias("PSPath")]
        [ValidateScript( {Test-Path -LiteralPath $_ -PathType leaf})]
        [string]
        $LiteralPath

    )

    begin {

        [System.Runtime.Serialization.IFormatter] $formatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter;
        [System.IO.FileStream] $stream = $null;

        switch ($PSBoundParameters.Keys) {

            'FilePath' { $ImportPath = $FilePath }
            'LiteralPath' { $ImportPath = $LiteralPath }

        }
    }

    process {

        try {

            $stream = [System.IO.FileStream]::new($ImportPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::Read)
            $returnval = ConvertFrom-Json -InputObject ($formatter.Deserialize($stream))
            $stream.Close()

        }
        catch {

            if ($null -ne $stream) {$stream.Close()}
            $PSCmdlet.ThrowTerminatingError($_)

        }
    }

    end {

        return $returnval;

    }
}
