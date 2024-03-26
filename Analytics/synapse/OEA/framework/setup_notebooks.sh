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

echo "--> Setting up the OEA Notebooks assets."

# 1) install notebooks
escaped_time_zone=$(printf '%s\n' "$time_zone" | sed -e 's/[\/&]/\\&/g')
sed "s/yourstorageaccount/$storage_account/" $this_file_path/notebook/oea_v1_0_oea_py.ipynb > $this_file_path/tmp/oea_v1_0_oea_py1.ipynb
sed "s/yourkeyvault/$key_vault/" $this_file_path/tmp/oea_v1_0_oea_py1.ipynb > $this_file_path/tmp/oea_v1_0_oea_py2.ipynb
sed "s/yourtimezone/$escaped_time_zone/" $this_file_path/tmp/oea_v1_0_oea_py2.ipynb > $this_file_path/tmp/oea_v1_0_oea_py3.ipynb
eval "az synapse notebook import --workspace-name $synapse_workspace --name oea_v1_0_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/tmp/oea_v1_0_oea_py3.ipynb --folder-path 'OEA/framework/v1.0/src' --only-show-errors"