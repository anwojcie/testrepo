#connect to a tenant
Connect-AzAccount -TenantId 'f07f9381-1c8c-4177-8dcd-d237ec684ff3' -Subscription 'c9d64979-fe33-42e7-95ff-a0fb560c6e11'

#Define the RG name
$rgName = "rg-disktests"

#Get the RG, no RG exists an error will the thrown
$rg = Get-AzResourceGroup -Name "$rgName"

#Create the RG if needed
if($rg.count -eq 0){
    $rg = New-AzResourceGroup -Name $rgName -Location "west europe"
}

#Validates the template
Test-AzResourceGroupDeployment -ResourceGroupName $rg.ResourceGroupName -TemplateParameterFile ".\products\manageddisk\0\demos\azuredeploy.parameters.json" -TemplateFile ".\products\manageddisk\0\armtemplates\azuredeploy.json" -Verbose

#Deploys the template
New-AzResourceGroupDeployment -ResourceGroupName $rg.ResourceGroupName -TemplateParameterFile ".\products\manageddisk\0\demos\azuredeploy.parameters.json" -TemplateFile ".\products\manageddisk\0\armtemplates\azuredeploy.json" -Verbose

#Cleans up by deleting the resource group
Remove-AzResourceGroup -Name $rgName -Verbose
