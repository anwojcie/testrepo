# Virtual Network
This module deploys virtual network with default subnet.
- Ijaz Rameez

## Resources

- Microsoft.Network/VirtualNetworks
- Microsoft.Network/VirtualNetworks/Subnets

## Security Control Framework

| Sec Control | Consideration | Comments |
| :-             | :-   | :-            |
| [F5. Tagging of all resources with relevant tags is in place](https://dev.azure.com/visolitcloud/Cloud%20Center%20of%20Excellence/_wiki/wikis/Cloud%20Center%20of%20Excellence/276/F5.-Tagging-of-all-resources-with-relevant-tags-is-in-place) | Adding resourcetags to the arm-template or parametersfile |  |

## Parameters

If you see "complex structure", look further down in the document for examples of that particular parameter.

| Parameter Name | Type | Default Value | Possible values | Description | Required |
| :-             | :-   | :-            | :-              | :-          | :- |
| `virtualNetworkName` | string | | | Name of the virtual network | Yes |
| `addressPrefix` | string | | IP address block in CIDR notation | An address block reserved for this virtual network in CIDR notation | Yes |
| `ddosProtectionPlanEnabled` | boolean | false | `true` or ` false` | Indicates if DDoS protection is enabled for all the protected resources in the virtual network | No |
| `resourceTags` | object | cemplex structure | complex structure | Resource tags | No |

### Parameter Usage: `addressPrefix`

Address prefix is an IP address block in CIDR notation that reserved for a virtual network. E.g. 10.0.0.0/16

```json
"addressPrefix": {
      "value": "10.0.0.0/16"
    },
```

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

## How to use
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
| `vnetResourceId` | The Resource Id of the virtual network.
| `vnetResourceGroup` | The name of the Resource Group the virtual network was created in.
| `vnetName` | The Name of the virtual network.

## Considerations

*N/A*

## Additional resources

- [Overview of Azure Virtual Network?](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network documentation.](https://docs.microsoft.com/en-us/azure/virtual-network/)
- [Azure Virtual Network ARM Template](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks)

