# Path to Log file
$TLog = 'C:\TopDesk_Export\Logs\iPadSync.log'

# Path to Export list
$iPadExport = 'C:\TopDesk_Export\iPads.csv'

# Number of iPads to load from AirWatch
$lookupLimit = '15000'

# AirWatch tenant Uri (replace with tenant URL)
$awconsoleURL = 'https://cnxxx.awmdm.com'

# AirWatch Authorization (Replace with base64 encoded credentials)
$aw64EncodedAuth = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=='

# AirWatch tentant Code (Replace with tenant code from AirWatch)
$tenantCode = 'AAAAAAAAAAAAAAAAAAAA'

# The total number of devices from AW
$TotalDevices = 0;

# RestError used to capture Rest Method errors
$RestError = "";

# SyncLog used to keep track of general errors & info
$SyncLog = [System.Collections.ArrayList]@();

#  AirWatch API
$awHeader = @{
    Authorization = "Basic $aw64EncodedAuth"
    Accept = "application/json"
    'aw-tenant-code' = $tenantCode
}

# Perform a Rest Call
function Get-APIResponse {

    [CmdletBinding()]
    param (
        # Header
        [parameter(mandatory=$true)]
        $Headers,

        # Use POST method? (default GET)
        [parameter(mandatory=$false)]
        [switch]$POST,

        # Uri for API Call
        [parameter(mandatory=$true)]
        $Uri,

        # Body to include in POST
        [parameter(mandatory=$false)]
        $Body,

        # API Name
        [Parameter(Mandatory=$true)]
        [string]
        $APIName
    )

    # Prep errors
    $RestError = "";
    try {
        if($POST) {
            if($Body) {
                $Request = Invoke-RestMethod -Method POST -Uri $Uri -Body $Body -Headers $Headers -ErrorVariable RestError;
            }
            else {
                $Request = Invoke-RestMethod -Method POST -Uri $Uri -Headers $Headers -ErrorVariable RestError;
            }
        }
        else {
            $Request = Invoke-RestMethod -Method GET -Uri $Uri -Headers $Headers -ErrorVariable RestError;   
        }

        if(!$RestError) {
            # Successful call, continue
            return $Request;
        }
        elseif (($RestError[0].InnerException.Response.StatusCode.value__) -eq '401') {
            $SyncLog.Add("Authorization problem in $($APIName) API call: Uri - $($Uri), Header - $($Headers), Body - $($Body)") | Out-Null;
            $RestError | Select-Object -First 1 | ForEach-Object {$script:SyncLog.Add($_) | Out-Null;}
            return "";
        }
        else {
            $SyncLog.Add("Problem in $($APIName) API call: Uri - $($Uri), Header - $($Headers), Body - $($Body)") | Out-Null;
            $RestError | Select-Object -First 1 | ForEach-Object {$SyncLog.Add($_) | Out-Null;}
            return "";
        }
    }
    catch {
        $SyncLog.Add("Problem in $($APIName) API call: Uri - $($Uri), Header - $($Headers), Body - $($Body)") | Out-Null;
        $SyncLog.Add($Error[0].Exception.Message) | Out-Null;
        $SyncLog.Add($Error[0].Exception.ScriptStackTrace) | Out-Null;
        return "";
    }
}

function Get-AWiPads {

    [CmdletBinding()]
    param (
        # Header
        [parameter(mandatory=$true)]
        $Headers,

        # AW Tenant API Uri
        [parameter(mandatory=$true)]
        $APIUri
    )
    try {
        Get-APIResponse -Uri $APIUri -Headers $Headers -APIName "AirWatch";
    }
    catch {
        $SyncLog.Add("Error loading iPads from AirWatch") | Out-Null;
        $SyncLog.Add($Error[0].Exception.Message) | Out-Null;
        $SyncLog.Add($Error[0].Exception.ScriptStackTrace) | Out-Null;
        return "";
    }
}

Start-Transcript -Path $TLog

Write-Verbose "Sync started: $((Get-Date).ToString())";
Write-Verbose "Loading iPads from AirWatch";

$AWDevListUri = $awconsoleURL + "/API/mdm/devices/search?pagesize=" + $lookupLimit
# Get list of AW iPads
$AWiPads = Get-AWiPads -Headers $awHeader -APIUri $AWDevListUri

if(($null -ne $AWiPads) -and ($AWiPads -ne "")) {
    
    $TotalDevices = ($AWiPads.Devices.Count);
    Write-Verbose "$($TotalDevices) loaded from AirWatch";

    # Modify an values desired to be changed before exporting
    $iPads = $AWiPads.Devices | Select-Object -Property @{Name='id';Expression={$_.SerialNumber}},
                                                                    @{Name='iPad-Name';Expression={$_.DeviceFriendlyName}},
                                                                    @{Name='iPad-Model';Expression={$_.Model}},
                                                                    @{Name='iPad-Device-ID';Expression={$_.Id.Value}},
                                                                    @{Name='iPad-MAC';Expression={$_.MacAddress}},
                                                                    @{Name='iPad-Asset-Number';Expression={$_.AssetNumber}},
                                                                    @{Name='iPad-Uuid';Expression={$_.Uuid}},
                                                                    @{Name='iPad-OS';Expression={$_.OperatingSystem}},
                                                                    @{Name='iPad-Location';Expression={$_.LocationGroupName}},
                                                                    @{Name='iPad-Username';Expression={$_.UserName}},
                                                                    @{Name='iPad-Enrollment';Expression={$_.LastEnrolledOn}},
                                                                    @{Name='Enrollment-Status';Expression={$_.EnrollmentStatus}},
                                                                    @{Name='iPad-Last-Seen';Expression={$_.LastSeen}},
                                                                    @{Name='iPad-Compliance';Expression={$_.ComplianceStatus}},
                                                                    @{Name='iPad-Compliance-Check';Expression={$_.LastComplianceCheckOn}},
                                                                    @{Name='iPad-Compromised';Expression={if($_.CompromisedStatus){'TRUE'}}},
                                                                    @{Name='iPad-Compromised-Check';Expression={$_.LastCompromisedCheckOn}},
                                                                    @{Name='iPad-Storage';Expression={[math]::Round($_.DeviceCapacity/1GB)}},
                                                                    @{Name='iPad-Storage-Available';Expression={[math]::Round($_.AvailableDeviceCapacity/1GB)}},
                                                                    @{Name='ipad-Supervised';Expression={if($_.IsSupervised){'TRUE'}}},
                                                                    @{Name='iPad-Activation-Lock';Expression={if($_.IsActivationLockEnabled){'TRUE'}}},
                                                                    @{Name='Cloud-Backup-Enabled';Expression={if($_.IsCloudBackupEnabled){'TRUE'}}},
                                                                    @{Name='SEA';Expression={if($_.LocationGroupName.Trim() -eq "SEA"){'TRUE'}}}

    $iPads | Export-Csv -Path $iPadExport -NoTypeInformation;
    
    # Sync Log
    if($SyncLog.Count -gt 0) {
        Write-Verbose "=====================  Sync Log  =====================";
        Write-Verbose "====================================================";
        Write-Verbose "$($SyncErrors.Count) Message(s) logged.";
        $SyncLog | ForEach-Object {Write-Verbose "$_"}
    }
}
else {
    Write-Warning "Unable to load iPads from AirWatch";
}

Write-Verbose "Sync Finished: $((Get-Date).ToString())";
Stop-Transcript