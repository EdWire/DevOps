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
# sed "s/yourstorageaccount/$storage_account/" $this_file_path/synapse/notebook/OEA_py.ipynb > $this_file_path/tmp/OEA_py1.ipynb
# sed "s/yourkeyvault/$key_vault/" $this_file_path/tmp/OEA_py1.ipynb > $this_file_path/tmp/OEA_py2.ipynb
# eval "az synapse notebook import --workspace-name $synapse_workspace --name OEA_py --spark-pool-name spark3p4sm --file @$this_file_path/tmp/OEA_py2.ipynb --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name ipeds_v0_1_migrate_s1_s3 --spark-pool-name spark3p4sm --file @$this_file_path/notebook/ipeds_v0_1_migrate_s1_s3.ipynb --folder-path 'OEA/modules/iPEDS/v0.1/src' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name SQL_Essentials --spark-pool-name spark3p4sm --file @$this_file_path/notebook/SQL_Essentials.ipynb --folder-path 'OEA/modules/iPEDS/v0.1/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_edfi_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_edfi_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_oea_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_fetch_urls --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_fetch_urls.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/utilities' --only-show-errors"

# # 3) setup pipelines
# # Note that the ordering below matters because pipelines that are referred to by other pipelines must be created first.
# eval "az synapse pipeline create --workspace-name $synapse_workspace --name create_lake_db --file @$this_file_path/synapse/pipeline/create_lake_db.json"
# sed "s/yourstorageaccount/$storage_account/" $this_file_path/synapse/pipeline/create_sql_db.json > $this_file_path/tmp/create_sql_db.json
# eval "az synapse pipeline create --workspace-name $synapse_workspace --name create_sql_db --file @$this_file_path/tmp/create_sql_db.json"
eval "az synapse pipeline create --workspace-name $synapse_workspace --name ipeds_migrate_s1_ss3 --file @$this_file_path/pipeline/ipeds_migrate_s1_ss3.json" 

echo "--> Setup complete. The IPEDS module assets have been installed in the specified synapse workspace: $synapse_workspace"
