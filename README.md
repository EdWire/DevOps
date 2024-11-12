# DevOps

## Scripts

### Select Azure Subscription

``` bash

az account show

az account set -s 'subscripion_id'

```

### Run OEA Framework

``` bash
# If using Azure Storage 
cd clouddrive

git clone https://github.com/EdWire/DevOps.git

cd DevOps/Analytics/synapse/OEA

./setup.sh -o 'kedcprod' -r 'eg-oea-rg-prod-eus' -l 'eastus'

```

### Assign User/Roles Permissions

#### If deploying to a customer's Azure Tenant/Subscription
- Create Security Group(s) in Microsoft Entra ID
  - "EdGraph Analytics - BI Developers"
    - Invite/Add rohan@edwire.com, arjun@edwire.com, mega@edwire.com
  - "EdGraph Analytics - Support Team"
    - Invite/Add sherod@edwire.com, daniel@edwire.com, taylor@edwire.com, jason@edwire.com, allison@edwire.com
  - "EdGraph Analytics - Report Authors"
    - Invite/Add Power BI Report Authors

- Go to the OEA Resource Group - Access Control (IAM)
  - Add "Owner" Eligible permissions to the following Azure AD Security Group(s):
    - "DevOps Engineers (Dev)" or "DevOps Engineers (Prod)"
    - "BI Developers (Dev)" or "BI Developers (Prod)"
  - Add "Reader" permissions to the following Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
    - "EdGraph Analytics - Support Team"
    - "EdGraph Analytics - Report Authors"
      
- Go to the Storage Account - Access Control (IAM)
  - Add "Storage Blob Data Contributor" permissions to the following Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
    - "EdGraph Analytics - Support Team"
    - "EdGraph Analytics - Report Authors"
    - "[Instance Service Principal]"
      
- Go to the Key Vault - Access Control (IAM)
  - Add "Key Vault Secret Officers" permissions to the following Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
  - Add "Key Vault Secret User" permissions to the following Azure AD Security Group(s):
    - "[Instance Service Principal]"

- Go to the Synapse Workspace - Manage - Access Control
  - Add "Synapse Administrator" permissions to the Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
    - "[Instance Service Principal]"

#### If deploying to EdGraph's Azure Tenant/Subscription
- Create Security Group(s) in Microsoft Entra ID
  - "[Subscription Name] - Support Team"
    - Invite/Add sherod@edwire.com, daniel@edwire.com, taylor@edwire.com, jason@edwire.com, allison@edwire.com
  - "[Subscription Name] - Report Authors"
    - Invite/Add Power BI Report Authors

- Go to the Subscription - Access Control (IAM)
  - Add "Owner" Eligible permissions to the following Azure AD Security Group(s):
    - "DevOps Engineers (Dev)" or "DevOps Engineers (Prod)"
    - "BI Developers (Dev)" or "BI Developers (Prod)"
  - Add "Reader" permissions to the following Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
    - "[Subscription Name] - Support Team"
    - "[Subscription Name] - Report Authors"
      
- Go to the Storage Account - Access Control (IAM)
  - Add "Storage Blob Data Contributor" permissions to the following Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
    - "[Subscription Name] - Support Team"
    - "[Subscription Name] - Report Authors"
    - "[Instance Service Principal]"
      
- Go to the Key Vault - Access Control (IAM)
  - Add "Key Vault Secret Officers" permissions to the following Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
  - Add "Key Vault Secret User" permissions to the following Azure AD Security Group(s):
    - "[Instance Service Principal]"

- Go to the Synapse Workspace - Manage - Access Control
  - Add "Synapse Administrator" permissions to the Azure AD Security Group(s):
    - "BI Developers (Dev)" or "BI Developers (Prod)"
    - "[Instance Service Principal]"

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
