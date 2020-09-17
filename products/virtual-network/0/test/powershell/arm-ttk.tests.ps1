#Download, Extract and Import ARM-TTK
Invoke-WebRequest https://azurequickstartsservice.blob.core.windows.net/ttk/latest/arm-template-toolkit.zip -OutFile "$Env:AGENT_TEMPDIRECTORY/arm-template-toolkit.zip" 
Expand-Archive -LiteralPath "$Env:AGENT_TEMPDIRECTORY/arm-template-toolkit.zip" -DestinationPath "$Env:AGENT_TEMPDIRECTORY/arm-template-toolkit" 
Import-Module "$Env:AGENT_TEMPDIRECTORY/arm-template-toolkit/arm-ttk/arm-ttk.psd1"
Get-Module
#Run Tests
$testresult = Test-AzTemplate -ErrorAction Continue
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