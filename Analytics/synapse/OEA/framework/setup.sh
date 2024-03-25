#!/bin/bash

# Installs the OEA framework assets.
# This script can be invoked directly to install the OEA framework into an existing Synapse Workspace.
# This script is also automatically called from the base setup.sh script when setting up the complete OEA example including the provisioning of Azure resources.
if [ $# -ne 4 ]; then
    echo "This setup script will install the OEA framework assets into an existing Synapse workspace."
    echo "Invoke this script like this:"
    echo "    setup.sh <synapse_workspace_name> <storage_account_name> <key_vault_name> <time_zone>"
    exit 1
fi

synapse_workspace=$1
storage_account=$2
key_vault=$3
time_zone=$4
this_file_path=$(dirname $(realpath $0))
mkdir $this_file_path/tmp

echo "--> Setting up the OEA framework assets."

# 1) install integration assets
#  - setup Linked Services 
sed "s/yourkeyvault/$key_vault/" $this_file_path/linkedService/LS_KeyVault.json > $this_file_path/tmp/LS_KeyVault.json
eval "az synapse linked-service create --workspace-name $synapse_workspace --name LS_KeyVault --file @$this_file_path/tmp/LS_KeyVault.json"
sed "s/yourstorageaccount/$storage_account/" $this_file_path/linkedService/LS_DataLake.json > $this_file_path/tmp/LS_DataLake.json
eval "az synapse linked-service create --workspace-name $synapse_workspace --name LS_DataLake --file @$this_file_path/tmp/LS_DataLake.json"
sed "s/yoursynapseworkspace/$synapse_workspace/" $this_file_path/linkedService/LS_SQL_Serverless.json > $this_file_path/tmp/LS_SQL_Serverless.json
eval "az synapse linked-service create --workspace-name $synapse_workspace --name LS_SQL_Serverless --file @$this_file_path/tmp/LS_SQL_Serverless.json"
eval "az synapse linked-service create --workspace-name $synapse_workspace --name LS_Azure_SQL_DB --file @$this_file_path/linkedService/LS_Azure_SQL_DB.json"
eval "az synapse linked-service create --workspace-name $synapse_workspace --name LS_HTTP --file @$this_file_path/linkedService/LS_HTTP.json"
eval "az synapse linked-service create --workspace-name $synapse_workspace --name LS_REST --file @$this_file_path/linkedService/LS_REST.json"

#  - setup Datasets
eval "az synapse dataset create --workspace-name $synapse_workspace --name DS_datalake_file --file @$this_file_path/dataset/DS_datalake_file.json"
eval "az synapse dataset create --workspace-name $synapse_workspace --name DS_datalake_folder --file @$this_file_path/dataset/DS_datalake_folder.json"
eval "az synapse dataset create --workspace-name $synapse_workspace --name DS_HTTP_binary --file @$this_file_path/dataset/DS_HTTP_binary.json"
eval "az synapse dataset create --workspace-name $synapse_workspace --name DS_Azure_SQL_DB --file @$this_file_path/dataset/DS_Azure_SQL_DB.json"

echo "--> Setup complete. The OEA framework assets have been installed in the specified synapse workspace: $synapse_workspace"

# 2) install notebooks
escaped_time_zone=$(printf '%s\n' "$time_zone" | sed -e 's/[\/&]/\\&/g')
sed "s/yourstorageaccount/$storage_account/" $this_file_path/notebook/oea_v1_0_oea_py.ipynb > $this_file_path/tmp/oea_v1_0_oea_py1.ipynb
sed "s/yourkeyvault/$key_vault/" $this_file_path/tmp/oea_v1_0_oea_py1.ipynb > $this_file_path/tmp/oea_v1_0_oea_py2.ipynb
sed "s/yourtimezone/$escaped_time_zone/" $this_file_path/tmp/oea_v1_0_oea_py2.ipynb > $this_file_path/tmp/oea_v1_0_oea_py3.ipynb
eval "az synapse notebook import --workspace-name $synapse_workspace --name oea_v1_0_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/tmp/oea_v1_0_oea_py3.ipynb --folder-path 'OEA/framework/v1.0/src' --only-show-errors"