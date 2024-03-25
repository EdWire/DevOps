#!/bin/bash

# Installs the IPEDS module
# This script can be invoked directly to install the IPEDS module assets into an existing Synapse Workspace.
if [ $# -ne 1 ]; then
    echo "This setup script will install the IPEDS module assets into an existing Synapse workspace."
    echo "Invoke this script like this:  "
    echo "    setup.sh <synapse_workspace_name>"
    exit 1
fi

synapse_workspace=$1
this_file_path=$(dirname $(realpath $0))

echo "--> Setting up the IPEDS module assets."

# 2) install notebooks
eval "az synapse notebook import --workspace-name $synapse_workspace --name ipeds_v0_1_migrate_s1_s3 --spark-pool-name spark3p4sm --file @$this_file_path/notebook/ipeds_v0_1_migrate_s1_s3.ipynb --folder-path 'OEA/modules/IPEDS/v0.1/src' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name SQL_Essentials --spark-pool-name spark3p4sm --file @$this_file_path/notebook/SQL_Essentials.ipynb --folder-path 'OEA/modules/IPEDS/v0.1/utilities' --only-show-errors"

# # 3) setup pipelines
# # Note that the ordering below matters because pipelines that are referred to by other pipelines must be created first.
eval "az synapse pipeline create --workspace-name $synapse_workspace --name ipeds_migrate_s1_ss3 --file @$this_file_path/pipeline/ipeds_migrate_s1_ss3.json" 

echo "--> Setup complete. The IPEDS module assets have been installed in the specified synapse workspace: $synapse_workspace"
