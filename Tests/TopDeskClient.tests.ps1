﻿#$moduleRoot = Resolve-Path "$PSScriptRoot"
#$moduleName = Split-Path $moduleRoot -Leaf

Describe "General project validation: $env:BHProjectName" {

    $scripts = Get-ChildItem $env:BHBuildOutput/$env:BHProjectName -Include *.ps1, *.psm1, *.psd1 -Recurse

    # TestCases are splatted to the script so we need hashtables
    $testCase = $scripts | Foreach-Object {@{file = $_}}
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)

        $file.fullname | Should Exist

        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }

    It "Module '$env:BHProjectName' can import cleanly" {
        {Import-Module "$env:BHBuildOutput/$env:BHProjectName/$env:BHProjectName.psd1" -force } | Should Not Throw
    }
}