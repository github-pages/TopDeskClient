function Get-APIResponse {

    [CmdletBinding(PositionalBinding = $false,
        ConfirmImpact = 'Medium')]
    [OutputType([PSObject])]

    param (

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [ValidateSet('GET', 'PUT', 'POST', 'PATCH', 'DELETE')]
        [string]
        $Method,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('url')]
        [string]
        $APIurl,

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers,

        # TopDesk Credentials
        [Parameter(Mandatory = $true)]
        [pscredential]
        $tdCredential,

        # Parameter help description
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Body

    )

    begin {

        if(!$Headers.ContainsKey('Authorization')) {
            
            $null = $Headers.Add('Authorization', ('Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($tdCredential.UserName + ':' + $tdCredential.GetNetworkCredential().Password))))
            
        }

    }

    process {

        if ($PSBoundParameters.ContainsKey('Body')) {

            return (Invoke-RestMethod -Method $Method -Uri $APIurl -Body $Body -Headers ($Headers))

        }
        else {

            return (Invoke-RestMethod -Method $Method -Uri $APIurl -Headers ($Headers))

        }
    }

    end {}
}