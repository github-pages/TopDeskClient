using namespace Microsoft.PowerShell.Commands

[CmdletBinding()]
param(
    [ValidateSet("CurrentUser", "AllUsers")]
    $Scope = "CurrentUser",
    $Task = 'regularBuild'
)

[ModuleSpecification[]]$RequiredModules = Import-LocalizedData -BaseDirectory $PSScriptRoot -FileName RequiredModules
$Policy = (Get-PSRepository PSGallery).InstallationPolicy
Set-PSRepository PSGallery -InstallationPolicy Trusted

try {
    $RequiredModules | Install-Module -Scope $Scope -Repository PSGallery -SkipPublisherCheck -Force
}
finally {
    Set-PSRepository PSGallery -InstallationPolicy $Policy
}

$RequiredModules | Import-Module

Invoke-Build -Task $Task