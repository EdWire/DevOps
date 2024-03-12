# DevOps

## Scripts

### Select Azure Subscription

``` bash

az account show

az account set -s 'subscripion_id'

```

### Run OEA Framework

``` bash

cd clouddrive

git clone https://github.com/EdWire/DevOps.git

cd DevOps/OEA

./setup.sh -o 'produsc' -r 'eg-oea-rg-production-usc' -l 'eastus'

```

### If the setup script fails

- Explore the setup log file for reason of the issue.

To run the setup script again:

- If the resource group is not shared with other resources
  - You can delete the entire resource group
- If the resource group is shared with other resources
  - Manually delete the resources specific to OEA
    - KeyVault
    - Storage Account
    - Synapse Workspace
- When deleting a KeyVault, it must also be purged (See the Manage Deleted Vaults feature in the Azure Portal)
- Execute the setup script again
