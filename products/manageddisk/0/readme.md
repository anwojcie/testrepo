# ProjectName

Minimum Viable Product for manged disk, supporting all SKUs, encryption at rest but not bitlocker encryption

- Author: Frode Omdal Arnesen

## Resources

Microsoft.Compute/disks

## Parameters

"diskName", name of the disk to attach

"sku", SKU of disks, see <https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types?toc=/azure/virtual-machines/linux/toc.json&bc=/azure/virtual-machines/linux/breadcrumb/toc.json#disk-comparison>

"diskSizeGB", size of disk in GB, minimum 4, max see SKU above

"maxShares", number of virtual machines that can read and write to the disk at the same time, default 1

"resourceTags", tags to apply to the disk

### Parameter Usage: `<parameter>`

Resource tags are a complex key value pairing:

        "resourceTags": {
            "value": {
                "Environment": "Dev",
                "Project": "Tutorial"
            }

## How to use

See demos folder

## Outputs

Full resource ID
