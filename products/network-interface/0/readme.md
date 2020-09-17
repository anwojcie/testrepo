# ProjectName
Description of project
- Author

## Resources
Which resources are deployed with this product

## Parameters
List and description of Parameters

### Parameter Usage: `<parameter>`
Detailed usage for parameters if needed (complex types)

## How to use
Description of project usage

## Outputs
List and details of template outputs

## Considerations
List considerations

## Additional resources
Documentation Links

**Example project readme for keyvault below**

# Network Interface

This module deploys Key Vault, with resource lock.
- author: Ijaz Rameez
- last updated: 02-09-2020

## Resources

- Microsoft.Network/networkinterfaces

## Parameters


| Parameter Name | Type | Default Value | Possible values | Description | Required |
| :-             | :-   | :-            | :-              | :-          | :- |
| `networkInterfaceName` | string | | | The name of the network interface. | Yes |
| `location` | string | `[resourceGroup(). location]` | `az account list-locations -o table` | String value provides location for resources in template. | No |


| `resourceTags` | object | cemplex structure | complex structure | Tags of the Azure Key Vault resource. | No |

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```
## How to use ##
**How to deploy the content of this ARM-template:** 
```powershell
az deployment group create --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

**How to validate the content of this ARM-template (Recommended) If any customizations been made in the template files, a validation of the settings might be good:** 
```powershell
az deployment group validate --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

## Outputs

| Output Name | Description |
| :-          | :-          |
| `keyVaultResourceId` | The Resource Id of the Key Vault.
| `keyVaultResourceGroup` | The name of the Resource Group the Key Vault was created in.
| `keyVaultName` | The Name of the Key Vault.
| `keyVaultUrl` | The Name of the Key Vault.

## Considerations

*N/A*

## Additional resources

- [What is Azure Key Vault?](https://docs.microsoft.com/en-us/azure/key-vault/key-vault-whatis)
