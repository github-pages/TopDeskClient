function Get-TDCredentail {

  $creds = Get-Credential -Message "Enter username & password to access your TopDesk API"
  return $creds;

}