# KeyVault

This module deploys Key Vault, with resource lock. Can store certificates, keys and secrets.
- author: Oscar Jacobsson

## Resources

- Microsoft.KeyVault/vaults
- Microsoft.KeyVault/vaults/providers/locks
- Microsoft.KeyVault/vaults/certificates
- Microsoft.KeyVault/vaults/keys
- Microsoft.KeyVault/vaults/secrets

## Security Control Framework

| Sec Control | Consideration | Comments |
| :-             | :-   | :-            |
| S2: Encryption at rest	|	OK: https://docs.microsoft.com/en-us/azure/security/fundamentals/encryption-atrest#azure-key-vault	|
| [F5. Tagging of all resources with relevant tags is in place](https://dev.azure.com/visolitcloud/Cloud%20Center%20of%20Excellence/_wiki/wikis/Cloud%20Center%20of%20Excellence/276/F5.-Tagging-of-all-resources-with-relevant-tags-is-in-place) | Adding resourcetags to the arm-template or parametersfile |  |

## Parameters

If you see "complex structure", look further down in the document for examples of that particular parameter.

| Parameter Name | Type | Default Value | Possible values | Description | Required |
| :-             | :-   | :-            | :-              | :-          | :- |
| `keyVaultName` | string | `MustBeAzureUnique` | Names that are not taken | Name of the Azure Key Vault, must be Azure unique. | Yes |
| `location` | string | `[resourceGroup(). location]` | `az account list-locations -o table` | String value provides location for resources in template. | No |
| `sku` | string | `Standard` | `Standard` or `Premium` | Differences linked [here](https://azure.microsoft.com/en-us/pricing/details/key-vault/). | No |
| `accessPolicies` | array | empty array `[]` | complex structure | Gives permissions within the Key Vault. More documentation [here](https://docs.microsoft.com/en-us/azure/key-vault/general/secure-your-key-vault#:~:text=You%20grant%20a%20user%2C%20group,add%20users%20to%20that%20group.). | No |
| `enabledForDeployment` | boolean | `false` | `true` or `false` | Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | No |
| `enabledForDiskEncryption` | boolean | `false` | `true` or ` false` | Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | No |
| `enabledForTemplateDeployment` | boolean | `false` | `true` or ` false` | Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | No |
| `enableRbacAuthorization` | boolean | `false` | `true` or ` false` | Property to specify whether the 'soft delete' functionality is enabled for this key vault. More documentation [here](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults#VaultProperties) | No |
| `enableSoftDelete` | boolean | `false` | `true` or ` false` | Property to specify whether the 'soft delete' functionality is enabled for this key vault. More documentation More documentation [here](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults#VaultProperties) | No |
| `softDeleteRetentionInDays` | integer | `90` | 7 ≤ days ≤ 90 | softDelete data retention in days. It accepts more then 7 and less then 90. | No |
| `networkAcls` | object | complex structure | complex structure | Rules governing the accessibility of the key vault from specific network locations. [NetworkRuleSet settings](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults#NetworkRuleSet) | No |
| `resourceTags` | object | cemplex structure | complex structure | Tags of the Azure Key Vault resource. | No |


### Parameter Usage: `accessPolicies`

An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When createMode is set to recover, access policies are not required. Otherwise, access policies are required. More documentation [here](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/accesspolicies)

Below example will give full access to given Object ID, it can be a AAD User, AAD Group or a Service Principal
```json
"accessPolicies": {
        "value": [
            {
                "objectId": "Object ID for a AAD User/group or a service principal",
                "tenantId": "Tenant ID",
                "permissions": {
                    "keys": [
                        "Get",
                        "List",
                        "Update",
                        "Create",
                        "Import",
                        "Delete",
                        "Recover",
                        "Backup",
                        "Restore"
                    ],
                    "secrets": [
                        "Get",
                        "List",
                        "Set",
                        "Delete",
                        "Recover",
                        "Backup",
                        "Restore"
                    ],
                    "certificates": [
                        "Get",
                        "List",
                        "Update",
                        "Create",
                        "Import",
                        "Delete",
                        "Recover",
                        "Backup",
                        "Restore",
                        "ManageContacts",
                        "ManageIssuers",
                        "GetIssuers",
                        "ListIssuers",
                        "SetIssuers",
                        "DeleteIssuers"
                    ]
                }
            },
            {
                "objectId": "1111-2222-3333-XXXX-YYYY",
                "tenantId": "1111-2222-3333-XXXX-YYYY",
                "permissions": {
                    "keys": [
                    ],
                    "secrets": [
                    ],
                    "certificates": [
                    ]
                }
            }
        ]
    }
```
### Parameter Usage: `networkAcls`

Rules governing the accessibility of the key vault from specific network locations. [NetworkRuleSet settings](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults#NetworkRuleSet)

```json
"networkAcls": {
    "value": {
        "defaultAction": "allow",
        "bypass": "AzureServices",
        "ipRules": [],
        "virtualNetworkRules": []
    },
    "metadata": {
        "description": "Rules governing the accessibility of the key vault from specific network locations."
    }
}
```
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

**How to validate the content of this ARM-template (Recommended).**
If any customizations been made in the template files, a validation of the settings might be good 
```powershell
az deployment group validate --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

## Outputs

| Output Name | Description |
| :-          | :-          |
| `keyVaultResourceId` | The Resource Id of the Key Vault.
| `keyVaultResourceGroup` | The name of the Resource Group the Key Vault was created in.
| `keyVaultName` | The Name of the Key Vault.
| `keyVaultUrl` | The URL of the Key Vault. Soon available!

## Considerations

*N/A*

## Additional resources

- [What is Azure Key Vault?](https://docs.microsoft.com/en-us/azure/key-vault/key-vault-whatis)
- [Key Vault ARM-template documentation.](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults)
- [Secure access to a key vault](https://docs.microsoft.com/en-us/azure/key-vault/general/secure-your-key-vault#:~:text=You%20grant%20a%20user%2C%20group,add%20users%20to%20that%20group.)