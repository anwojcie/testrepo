#Auth to KeyVault endpoint as AzDevOps does not do this on its own
$context= Get-AzContext
$resource="https://vault.azure.net"
$token = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, $resource).AccessToken
              
#Get deploymentOutputs
if ($env:KEYVAULTOUTPUT){
    $deploymentOutputs = $env:KEYVAULTOUTPUT | convertfrom-json
    $deploymentOutputs | select * | fl
    }
              
$KeyVault = $($deploymentOutputs.keyVaultName.value)
$SPNID = "aceadfcb-27e5-4832-885c-2fa7259e2d1c" 
$SecretName = "TestSecret"
$SecretText = "ITops@2022"
              
# Assign Permissions to ServicePrincipal
              
$SPN = (Get-AzADServicePrincipal -ApplicationId $SPNID).ServicePrincipalNames[0]
Set-AzKeyVaultAccessPolicy -VaultName $KeyVault -ServicePrincipalName $SPN -PermissionsToSecrets Get,List,Set,Delete
              
# Add a Secret to the vault
$secretvalue = ConvertTo-SecureString $SecretText -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $KeyVault -Name $SecretName -SecretValue $secretvalue
              
# Retrieve secret from the vault and verify with pipeline variable
$Result=(Get-AzKeyVaultSecret -vaultName $KeyVault -name $SecretName).SecretValueText
if ($SecretText=$Result) {Write-Host "Secret is successfully retrieved from KeyVault"}
    else
        { Write-Error "Failed to retrieve Secret from KeyVault" }
              
# Delete Service Account and Secret
              
Remove-AzKeyVaultSecret -VaultName $KeyVault -Name $SecretName -Force 