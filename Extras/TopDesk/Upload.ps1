[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Directory containing csv exports
$ExportRoot = "C:\TopDesk_Export"
# List of export files to be uploaded
$Exports = @("SCCM.csv","Chromebook.csv","iPad.csv")

# TopDesk API
$TopDeskService = 'https://customer-name.topdesk.net/services'

# TopDesk Auth Header
$TopDeskAuthHeader = @{
    'Authorization' = 'Basic AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=='
    'Content-Type' = 'application/octet-stream'
}

foreach ($Export in $Exports) {

      $UploadFile = (Join-Path -Path $ExportRoot -ChildPath $Export)

      if(Test-Path $UploadFile) {

            try {

                  $url = $TopDeskService + '/import-to-api-v1/api/sourceFiles?filename=' + $Export
                  Write-Output "Uploading " $UploadFile  " to " $url
                  Invoke-RestMethod -Uri $url -Method PUT -headers $TopDeskAuthHeader -InFile $UploadFile
            }
            catch {
                  Write-Output ("Error uploading export to SUPPORTdesk. File: {0}" -f $Export)
                  Write-Output ("Error: {0}" -f $_.Exception.Message)
                  Write-Output ("Trace: {0}" -f $_.Exception.ScriptStackTrace)
            }
      }
      else {
            Write-Warning ("Not uploading export file, can not find file: {0}" -f $UploadFile)
      }
}
