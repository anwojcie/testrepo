# Purpose of the armtemplates folder

## azuredeploy.json

Deploys a simple raw managed disk, no extended encryption in the OS but platform encryption at rest.

### Parameters

"diskName", name of the disk to attach

"sku", SKU of disks, see <https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types?toc=/azure/virtual-machines/linux/toc.json&bc=/azure/virtual-machines/linux/breadcrumb/toc.json#disk-comparison>

"diskSizeGB", size of disk in GB, minimum 4, max see SKU above

"maxShares", number of virtual machines that can read and write to the disk at the same time, default 1

"resourceTags", tags to apply to the disk
