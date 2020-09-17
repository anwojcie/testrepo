#Download, Extract and Import ARM-TTK
Invoke-WebRequest https://azurequickstartsservice.blob.core.windows.net/ttk/latest/arm-template-toolkit.zip -OutFile "$Env:HOME/arm-template-toolkit.zip" 
Expand-Archive -LiteralPath "$Env:HOME/arm-template-toolkit.zip" -DestinationPath "$Env:HOME/arm-template-toolkit" 
Import-Module "$Env:HOME/arm-template-toolkit/arm-ttk/arm-ttk.psd1"
Get-Module
$ScriptDir = 'products\virtual-network\0'
#Split-Path $script:MyInvocation.MyCommand.Path -Parent
 
Write-Host "Current script directory is $ScriptDir"
#Run Tests
$testresult = Test-AzTemplate -ErrorAction Continue -TemplatePath $ScriptDir
$testedFiles = $testresult.file.FullPath | Sort-Object -Unique
$testedFiles | ForEach-Object {
    $thisfile = $_
    Describe "$thisfile".Replace("$Env:BUILD_REPOSITORY_LOCALPATH/products", "") {
        #Iterate through groups and set it as context
        ($testresult | Where-Object { $_.file.FullPath -eq $thisfile }).group | Sort-Object -Unique | ForEach-Object {
            $thiscontext = $_
            Context $thiscontext {
                $testresult | Where-Object { $_.file.FullPath -eq $thisfile -AND $_.group -eq $thiscontext } | ForEach-Object {
                    It "<name> - Passed" -TestCases @{name = $_.name; passed = $_.passed ;Errors = $_.Errors } {
                        param($passed,$Errors)
                        $Errors | Should -BeNullOrEmpty
                        $passed | Should -be $true
                    
                    }
                }
            } 
        }
    }
}