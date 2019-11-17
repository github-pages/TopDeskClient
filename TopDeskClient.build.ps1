<#
.Synopsis
	Build script (https://github.com/rbury/TopDeskClent)
#>

$Compliance = 50

Get-Item env:BH* | Remove-Item -ErrorAction SilentlyContinue
Set-BuildEnvironment -ErrorAction Stop

if ($env:BHBuildSystem -eq 'Unknown') {
    $env:Common_TestResultsDirectory = "$env:BHProjectPath/Tests/Results"
}

task Clean {

    if (Get-Module $env:BHProjectName) {
        Remove-Module $env:BHProjectName
    }

    if (Test-Path -Path "$env:BHBuildOutput" ) {
        $null = Remove-Item "$env:BHBuildOutput" -Recurse -Force
    }

    $null = New-Item "$env:BHBuildOutput/$env:BHProjectName" -ItemType Directory -Force

    if (Test-Path -Path "$env:BHProjectPath/Tests/Results") {
        $null = Remove-Item "$env:BHProjectPath/Tests/Results" -Recurse -Force
    }

    $null = New-Item "$env:BHProjectPath/Tests/Results" -ItemType Directory -Force

}

task GenDocs {

    if (Test-Path -Path "$env:BHBuildOutput/$env:BHProjectName/en-US" ) {
        $null = Remove-Item "$env:BHBuildOutput/$env:BHProjectName/en-US" -Recurse -Force
    }
    Import-Module "$env:BHBuildOutPut/$env:BHProjectName/$env:BHProjectName.psd1" -Force

    #Update-MarkdownHelp "$env:BHProjectPath/Docs" -ErrorAction SilentlyContinue
    New-MarkdownHelp -Module $env:BHProjectName -OutputFolder "$env:BHBuildOutput/$env:BHProjectName/en-US" -WithModulePage -ErrorAction SilentlyContinue
    New-ExternalHelp -OutputPath "$env:BHBuildOutput/$env:BHProjectName/en-US" -Path "$env:BHBuildOutput/$env:BHProjectName/en-US" -ShowProgress -Force -ErrorAction SilentlyContinue
    $null = Remove-Item "$env:BHBuildOutput/$env:BHProjectName/en-US/*.md" -Recurse -Force

}

task Analyze {
    $scriptAnalyzerParams = @{
        Path     = "$env:BHBuildOutput/$env:BHProjectName"
        Severity = @('Error', 'Warning')
        Recurse  = $true
        Verbose  = $false
    }

    $saResults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    $saResults | ConvertTo-Json | Set-Content "$env:Common_TestResultsDirectory/AnalysisResults.json"

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings where found."
    }
}

task PreTest {

    Import-Module $env:BHPSModuleManifest -Force

    $invokePesterParams = @{
        OutputFile                   = "$env:Common_TestResultsDirectory/TEST-Results-$($env:BHProjectName).xml"
        OutputFormat                 = 'NUnitXml'
        Strict                       = $true
        PassThru                     = $true
        Verbose                      = $false
        EnableExit                   = $false
        CodeCoverage                 = (Get-ChildItem $env:BHModulePath -Recurse -Include '*.psm1', '*.ps1' -Exclude '*.Tests.*').FullName
        CodeCoverageOutputFile       = "$env:Common_TestResultsDirectory/Coverage-$($env:BHProjectName).xml"
        CodeCoverageOutputFileFormat = 'JaCoCo'
        Script                       = (Get-ChildItem -Path "$env:BHProjectPath/Tests" -Recurse -Include '*.tests.ps1' -Exclude "$env:BHProjectName.tests.ps1" -Depth 5 -Force)
    }

    $testResults = Invoke-Pester @invokePesterParams;

    $testresults | ConvertTo-Json | Set-Content "$env:Common_TestResultsDirectory/PesterResults.json"

    $overallCoverage = [Math]::Floor(($testResults.CodeCoverage.NumberOfCommandsExecuted / $testResults.CodeCoverage.NumberOfCommandsAnalyzed) * 100)
    assert($overallCoverage -ge $Compliance) ('Code Coverage: "{0}", build requirement: "{1}"' -f $overallCoverage, $Compliance)

    if ($testResults.FailedCount -gt 0) {
        throw "$($testResults.FailedCount) tests failed."
    }

}

task Test {
    Import-Module "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -Force
    $res = Invoke-Pester -Script "$env:BHProjectPath/Tests/$env:BHProjectName.tests.ps1" -PassThru

    if ($res.FailedCount -gt 0) {

        throw "$($res.FailedCount) tests failed."

    }
}

task Build {
    if (-not(Test-Path "$env:BHBuildOutput/$env:BHProjectName")) {
        $null = New-Item -Path  "$env:BHBuildOutput/$env:BHProjectName" -ItemType Directory -Force
    }

    $null = New-Item -Path  "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    @'
    Set-StrictMode -Version latest

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $script:tdCredential = [pscredential]::Empty
    $script:tdAPIVersion = 0
    $script:tdConnected = $false
    $script:tdURI = ''

'@ | Add-Content -Path "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    Get-ChildItem -Path "$env:BHModulePath/Private/*.ps1" -Recurse | Get-Content | Add-Content "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    $Public = @( Get-ChildItem -Path "$env:BHModulePath/Public/*.ps1" -Force )
    $Public | Get-Content | Add-Content "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    $PublicFunctions = $Public.BaseName
    $newVersion = (& GitVersion.exe /output json /showvariable MajorMinorPatch)

    #Update-ModuleManifest -Path "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -ModuleVersion $newVersion -FunctionsToExport $PublicFunctions
    Copy-Item -Path "$env:BHPSModuleManifest" -Destination "$env:BHBuildOutput/$env:BHProjectName/" -Force

    Set-ModuleFunction -Name "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -FunctionsToExport $PublicFunctions
    Update-Metadata -Path "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -PropertyName ModuleVersion -Value $newVersion
}

task Bump {
    $vpatch = gitversion.exe /output json /showvariable Patch
    $vmaj = gitversion.exe /output json /showvariable Major
    $vmin = gitversion.exe /output json /showvariable Minor
    $ver = "$vmaj.$vmin.$([int]$vpatch+1)"
    Update-Metadata -Path "$env:BHPSModuleManifest" -Value $ver
    $tagVersion = Get-Metadata -Path "$env:BHPSModuleManifest"
    & git.exe tag -a $tagVersion -m "version $tagVersion"
}

task MajorBump {
    $vpatch = gitversion.exe /output json /showvariable Patch
    $vmaj = gitversion.exe /output json /showvariable Major
    $vmin = gitversion.exe /output json /showvariable Minor
    $ver = "$([int]$vmaj+1).$vmin.$vpatch"
    Update-Metadata -Path "$env:BHPSModuleManifest" -Value $ver
    $tagVersion = Get-Metadata -Path "$env:BHPSModuleManifest"
    & git.exe tag -a $tagVersion -m "version $tagVersion"
}

task MinorBump {
    $vpatch = gitversion.exe /output json /showvariable Patch
    $vmaj = gitversion.exe /output json /showvariable Major
    $vmin = gitversion.exe /output json /showvariable Minor
    $ver = "$vmaj.$([int]$vmin+1).$vpatch"
    Update-Metadata -Path "$env:BHPSModuleManifest" -Value $ver
    $tagVersion = Get-Metadata -Path "$env:BHPSModuleManifest"
    & git.exe tag -a $tagVersion -m "version $tagVersion"
}

task ReleaseNotes {
    Update-Metadata -Path "$env:BHPSModuleManifest" -Property ReleaseNotes -Value (Get-Content -Path "$env:BHProjectPath/ReleaseNotes.md")
}

task Help {
    #Remove-Module $env:BHProjectName -ErrorAction SilentlyContinue
    Import-Module "$env:BHBuildOutPut/$env:BHProjectName/$env:BHProjectName.psd1" -Force
    Update-MarkdownHelp "$env:BHProjectPath/docs" -ErrorAction SilentlyContinue
}

task Archive {
    Compress-Archive -Path "$env:BHBuildOutput/$env:BHProjectName" -DestinationPath "$env:BHBuildOutput/$env:BHProjectName.zip"
}

task regularBuild Clean, PreTest, Build, Analyze, Test

task fullBuild Clean, Build, Analyze, Test, GenDocs, Archive

task Testing Clean, PreTest, Analyze
