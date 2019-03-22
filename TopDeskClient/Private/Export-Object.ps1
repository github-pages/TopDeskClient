function Export-Object {

[CmdletBinding(DefaultParameterSetName = 'Default',
              PositionalBinding = $false,
              ConfirmImpact = 'Medium')]
    [OutputType([NullString])]

    Param (

        # Specify the path to an export directory
        [Parameter(Mandatory = $true,
                    ParameterSetName = 'Default',
                    ValueFromPipelineByPropertyName = $true)]
        [Alias('Path')]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $FilePath,

        # Specify a literal path to the export directory.
        [Parameter(Mandatory = $true,
                    ParameterSetName = "LiteralPath",
                    ValueFromPipelineByPropertyName = $true)]
        [Alias("PSPath")]
        [ValidateScript({Test-Path -LiteralPath $_ -PathType Container})]
        [string]
        $LiteralPath,

        # One or more objects to export
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        [Alias('Object')]
        [psobject[]]
        $ExportObject,

        # Name of export file
        [Parameter(Mandatory=$true,
        ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('Name')]
        [string]
        $FileName

    )

    begin {

        [System.IO.FileStream] $stream = $null
        [System.Runtime.Serialization.IFormatter] $formatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter

        switch ($PSBoundParameters.Keys) {

            'FilePath' { $ExportPath = $FilePath }
            'LiteralPath' { $ExportPath = $LiteralPath }

        }
    }

    process {

        foreach ($obj in $ExportObject) {

            $ExportFile = (Join-Path $ExportPath -ChildPath "$FileName")

            try {

                $stream = [System.IO.FileStream]::new($ExportFile, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
                $formatter.Serialize($stream,(ConvertTo-Json -InputObject $Obj -Depth 50 -Compress))
                $stream.Close();

            }
            catch {

                if($null -ne $stream) {$stream.Close()}
                throw($_)

            }
        }
    }

  end {}

}
