# Public IP

This module creates a Public IP address resource in Azure.
- author: Oscar Jacobsson

## Resources

- Microsoft.Network/publicIPAddresses

## Default Parameters
For these settings, use azuredeploy.json & azuredeploy.parameters.json
| Parameter Name | Type | Default Value | Possible values | Description | Required |
| :-             | :-   | :-            | :-              | :-          | :- |
| `name` | string | none | Names that are not taken | Name of the Azure Resource | Yes |
| `location` | string | `[resourceGroup(). location]` | `az account list-locations -o table` | Location for all resources | No |
| `sku` | string | `Basic` | `Basic` and `Standard` | Type of SKU for the Public IP resource | No |
| `publicIPAllocationMethod` | string | `Dynamic` | `Dynamic` or `Static` | The public IP address allocation method | No |
| `publicIpAddressVersion` | string | `IPv4` | `IPv4` or `IPv6` | The public IP address version | No |
| `domainNameLabel` | string | none | a fqdn | The concatenation of the domain name label and the regionalized DNS zone make up the fully qualified domain name associated with the public IP address. [Documentation](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses#PublicIPAddressDnsSettings) | No |
| `idleTimeoutInMinutes` | integer | `4` | integers | The idle timeout of the public IP address | No |
| `tags` | object | Complex structure, see below. | Complex structure, see below. | Tags of the Azure resource. Security Framework Control F5 requires it. | Yes |

## Advanced Parameters
For these additional settings, use azuredeployAdvanced.json & azuredeployAdvanced.parameters.json
| Parameter Name | Type | Default Value | Possible values | Description | Required |
| :- | :- | :- | :- | :- | :- |
| `ipAddress` | string | none | Valid IPv4 or IPv6 address | The IP address associated with the public IP address resource | no |
| `fqdn` | string | none | a fqdn | The Fully Qualified Domain Name of the A DNS record associated with the public IP. This is the concatenation of the domainNameLabel and the regionalized DNS zone. [Documentation](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses#PublicIPAddressDnsSettings) | No |
| `reverseFqdn` | string | none | a fqdn | The reverse FQDN. A user-visible, fully qualified domain name that resolves to this public IP address [Documentation](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses#PublicIPAddressDnsSettings) | No |
| `ddosCustomPolicyID` | string | none | valid resource id | A existing DDoS custom policy to associate with the public IP. | No |
| `publicIPPrefixID` | string | none | valid resource id | The Public IP Prefix this Public IP Address should be allocated from | No |
| `zoneList` | list | none | dns zone names | A list of availability zones denoting the IP allocated for the resource needs to come from | No |

<!--
| `parameter` | type | default value | possible values | description | required |
[Public IP template docs.](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses)
[Public IP documentation](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-addresses)
-->
### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Owner": "first.lastname@visolit.no",
        "businessImpactAccessCode": 1,
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
    }
}
```
## How to use
### How to deploy the content of this ARM-template:
```powershell
az deployment group create --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

### How to validate the content of this ARM-template (Recommended) If any customizations been made in the template files, a validation of the settings might be useful:
```powershell
az deployment group validate --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

## How to use this resource in a deployment:

You can use this resource in the following Azure Resources:

- Virtual machine network interfaces
- Internet-facing load balancers
- VPN gateways
- Application gateways
- Azure Firewall

*Source: [Public IP addresses](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-addresses#:~:text=Public%20IP%20addresses%20allow%20Internet,until%20it's%20unassigned%20by%20you.)*

When deploying, in instance a VM NIC, add the following JSON-block to the ARM-parameters file, or to the variables part of your ARM-template file.
*Remember to change the values within the '<>'. Example, change `<subscriptionID>` to the Subscription ID you're deploying in.*

```json
"publicIpAddressId": {
    "value": "/subscriptions/<subscriptionID>/resourceGroups/<ResourceGroup>/providers/Microsoft.Network/publicIPAddresses/<PublicIPAddressName>"
}
```

Then in the resource part of the deployment file, add/modify the `"properties"` part for IP configurations. In the IP configuration you can specify what the ID of the existing Public IP address resource is. So the Public IP address will be associated with your Azure Resource. See JSON-block example of a NIC configuration:

```json
"resources": [
    {
        "name": "[parameters('networkInterfaceName')]",
        "type": "Microsoft.Network/networkInterfaces",
        "apiVersion": "2019-07-01",
        "location": "[parameters('location')]",
        "properties": { // this block of the code
            "ipConfigurations": [
                {
                    "name": "ipconfig1",
                    "properties": {
                        "subnet": {
                            "id": "[variables('subnetRef')]"
                        },
                        "privateIPAllocationMethod": "Dynamic",
                        "publicIpAddress": {
                            "id": "[parameters('publicIpAddressId')]" 
                            // here we reference to our parameter Public IP address resource
                        }
                    }
                }
            ],
            "networkSecurityGroup": {
                "id": "[variables('nsgId')]"
            }
        } // example ends here
    },
    ...
```

## Outputs

| Output Name | Description |
| :-          | :-          |
| `name` | Displays the name of the provided resource |
| `publicIpAddressVersion` | Displays the IP version |
| `provisioningState` | Displays the provisioning state |
| `tags` | Displays the tags added to the resource |

## Considerations

*N/A*

## Additional resources

- [Public IP address](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-addresses)
- [Public IP Documentation](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses)
