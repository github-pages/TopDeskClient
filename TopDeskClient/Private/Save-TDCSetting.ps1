function Save-TDCSetting {

    [CmdletBinding(DefaultParameterSetName = 'DefaultSave',
        PositionalBinding = $false,
        ConfirmImpact = 'Medium')]
    [OutputType([NullString])]

    Param()

    begin {

        if ($Script:tdConnected) {

            $_instance = $script:tdURI.Replace("https://", "")
            $_savePath = "$env:APPDATA\TopDeskClient\$_instance"

            if (!(Test-Path -Path $_savePath)) {

                $null = New-Item -Path $_savePath -ItemType Container

            }
        }
    }

    process {

        if ($Script:tdConnected) {

            $_mySettings = @{
                'URI' = $script:tdURI
                'CRD' = @(
                    ($script:tdCredential.UserName),
                    ($script:tdCredential.Password | ConvertFrom-SecureString)
                )
            }

            Export-Object -Path $_savePath -ExportObject $_mySettings -Name 'settings.bin'
        }
        else {

            Write-Warning -Message "Connect to TopDesk before saving instance settings using Connect-TopDesk"

        }
    }

    end {}

}