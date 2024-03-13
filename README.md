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

./setup.sh -o 'produsc' -r 'eg-oea-rg-production-usc' -l 'southcentralus'

```

### Assign USer/Roles Permissions

- Create Security Group(s) in Microsoft Entra ID
  - "EdGraph Analytics Contributors"
  - Add members/users to Security Group
- Go to the Resource Group - Access Control (IAM)
  - Add "Contributor" permissions to the Azure AD Security Group
- Go to the Storage Account - Access Control (IAM)
  - Add "Storage Blob Data Contributor" permissions to the Azure AD Security Group
- Go to the Key Vault - Access Policies
  - Select "Secret Management" template
  - Add "permissions to the Azure AD Security Group
- Go to the Synapse Workspace - Manage - Access Control
  - Add "Storage Blob Data Contributor" permissions to the Azure AD Security Group

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
