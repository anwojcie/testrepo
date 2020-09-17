# Network Security Groups

Product is used to protect the Virtual Network 1.0 so that only RDP traffic from Public IP is allowed

- Author: Jeremias Jansson <jeremias.jansson@visolit.se>
- last updated: 2020-09-03

## Resources

- Microsoft.Network/networkSecurityGroups

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `networkSecurityGroupsName` | string | | | Required. Name of the network security group
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources
| `resourceTags` | object | {} | Complex structure, see below. | Optional. Tags for the Network Security Group resource

### Parameter Usage: `resourceTags`

ResourceTags names and values can be provided as needed, provided exampletags implements the F5 Security Control Framework

```json
"resourceTags": {
    "value": {
        "owner": "joe.schmo@visolit.se",
        "businessImpactAccessCode": "1",
        "environment": "production"
    }
}
```

## How to use

**How to deploy the content of this ARM-template:** 
```powershell
az deployment group create --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

**How to validate the content of this ARM-template (Recommended) If any customizations been made in the template files, a validation of the settings might be good:** 
```powershell
az deployment group validate --resource-group <insert_resource_group> --template-file <file_path.json> --parameters <file_path.parameters.json>
```

## Outputs

| Output Name | Type | Description |
| :-          | :-   | :-          |
| `networkSecurityGroupsResourceId` | string |The Resource Id of the created Network Security Group
| `networkSecurityGroupsResourceGroup` | string | The name of the Resource Group the Network Security Group was created in
| `networkSecurityGroupsName` | string | The Name of the Network Security Group

## Considerations

*none*

## Additional resources

[Microsoft.Network networkSecurityGroups template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups)