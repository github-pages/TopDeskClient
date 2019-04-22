$Compliance = 1

if($env:BHBuildSystem -eq 'Unknown') {
    $env:Common_TestResultsDirectory = "$env:BHProjectPath/Tests/Results"
}

task Clean {

    if(Get-Module $env:BHProjectName) {

        Remove-Module $env:BHProjectName

    }
    if(Test-Path -Path "$env:BHBuildOutput/$env:BHProjectName" ) {

        $null = Remove-Item "$env:BHBuildOutput/$env:BHProjectName" -Recurse -Force

    }

}

task GenDocs Help {

    New-ExternalHelp "$env:BHProjectPath\Docs" -OutputPath "$env:BHBuildOutput/$env:BHProjectName/en-US" -Force -ErrorAction SilentlyContinue

}

task Analyze {
    $scriptAnalyzerParams = @{
        Path     = "$env:BHModulePath"
        Severity = @('Error', 'Warning')
        Recurse  = $true
        Verbose  = $false
    }

    $saResults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    # Save Analyze Results as JSON
    $saResults | ConvertTo-Json | Set-Content "$env:Common_TestResultsDirectory/AnalysisResults.json"

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings where found."
    }
}

task PreTest {

    Import-Module $env:BHPSModuleManifest

    $invokePesterParams = @{
        OutputFile   = "$env:Common_TestResultsDirectory/TEST-Results-$($env:BHProjectName).xml"
        OutputFormat = 'NUnitXml'
        Strict       = $true
        PassThru     = $true
        Verbose      = $false
        EnableExit   = $false
        CodeCoverage = (Get-ChildItem $env:BHModulePath -Recurse -Include '*.psm1', '*.ps1' -Exclude '*.Tests.*').FullName
        Script       = (Get-ChildItem -Path "$env:BHModulePath/Tests" -Recurse -Include '*.tests.ps1' -Depth 5 -Force)
    }

    # Save Test Results as NUnitXml
    $testResults = Invoke-Pester @invokePesterParams;

    # Save Test Results as JSON
    $testresults | ConvertTo-Json | Set-Content "$env:Common_TestResultsDirectory/PesterResults.json"

    # Fail Build if Coverage is under requirement
    $overallCoverage = [Math]::Floor(($testResults.CodeCoverage.NumberOfCommandsExecuted / $testResults.CodeCoverage.NumberOfCommandsAnalyzed) * 100)
    assert($overallCoverage -ge $Compliance) ('Code Coverage: "{0}", build requirement: "{1}"' -f $overallCoverage, $Compliance)

}

task Test {
    Import-Module "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -Force
    $res = Invoke-Pester -Script "$env:BHModulePath/Tests/$env:BHProjectName.tests.ps1" -PassThru

    if ($res.FailedCount -gt 0) {
        
        throw "$($res.FailedCount) tests failed."
    
    }
}

task Build {
    if(-not(Test-Path "$env:BHBuildOutput/$env:BHProjectName")) {
        $null = New-Item -Path  "$env:BHBuildOutput/$env:BHProjectName" -ItemType Directory -Force
    }

    Copy-Item -Path "$env:BHModuleManifest" -Destination "$env:BHBuildOutput/$env:BHProjectName/" -Force
    $null = New-Item -Path  "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    Get-ChildItem -Path "$env:BHModulePath/Private/*.ps1" -Recurse | Get-Content | Add-Content "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    $Public = @( Get-ChildItem -Path "$env:BHModulePath/Public/*.ps1" -Force )
    $Public | Get-Content | Add-Content "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psm1" -Force
    $PublicFunctions = "'$($Public.BaseName -join "', '")'"
    $newVersion = (& GitVersion.exe /output json /showvariable SemVer)
    Update-ModuleManifest -Path "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -ModuleVersion $newVersion -FunctionsToExport $PublicFunctions

}

task Help {
    Import-Module "$env:BHBuildOutPut/$env:BHProjectName/$env:BHProjectName.psd1" -Force
    New-MarkdownHelp -Module $env:BHProjectName -Force -OutputFolder "$env:BHBuildOutPut/docs" -ErrorAction SilentlyContinue
    Update-MarkdownHelp "$env:BHBuildOutput/docs" -ErrorAction SilentlyContinue
    #New-ExternalHelp -Path "$env:BHBuildOutPut/docs" -OutputPath "$env:BHBuildOutput/$env:ProjectName/en-US" -Force -ErrorAction SilentlyContinue
}

task Archive {
    Compress-Archive -Path "$env:BHBuildOutput/$env:BHProjectName" -DestinationPath "$env:BHBuildOutput/$env:BHProjectName.zip"
}

task regularBuild Clean, Analyze, PreTest, Build, Test, Help

task fullBuild Clean, Analyze, PreTest, Build, Test, GenDocs, Archive