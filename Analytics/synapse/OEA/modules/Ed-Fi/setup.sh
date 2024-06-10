#!/bin/bash

# Installs the Ed-Fi module
# This script can be invoked directly to install the Ed-Fi module assets into an existing Synapse Workspace.
if [ $# -ne 4 ]; then
    echo "This setup script will install the Ed-Fi module assets into an existing Synapse workspace."
    echo "Invoke this script like this:  "
    echo "    setup.sh <synapse_workspace_name> <storage_account_name> <key_vault_name> <time_zone>"
    exit 1
fi

synapse_workspace=$1
storage_account=$2
key_vault=$3
time_zone=$4
escaped_time_zone=$(printf '%s\n' "$time_zone" | sed -e 's/[\/&]/\\&/g')
this_file_path=$(dirname $(realpath $0))
mkdir -p $this_file_path/tmp

echo "--> Setting up the Ed-Fi module assets."

# 2) install notebooks
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_ingest --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_ingest.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_land --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_land.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_main_etl_pipeline --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_main_etl_pipeline.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_prepare_metadata --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_prepare_metadata.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"

#sed "s/yourstorageaccount/$storage_account/" $this_file_path/notebook/edfi_v0_7_refine.ipynb > $this_file_path/tmp/edfi_v0_7_refine1.ipynb
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_refine --spark-pool-name spark3p4sm --file @$this_file_path/tmp/edfi_v0_7_refine1.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_edfi_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_edfi_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/utilities' --only-show-errors"

#sed "s/yourstorageaccount/$storage_account/" $this_file_path/notebook/edfi_v0_7_oea_py.ipynb > $this_file_path/tmp/edfi_v0_7_oea_py1.ipynb
#sed "s/yourkeyvault/$key_vault/" $this_file_path/tmp/edfi_v0_7_oea_py1.ipynb > $this_file_path/tmp/edfi_v0_7_oea_py2.ipynb
#sed "s/yourtimezone/$escaped_time_zone/" $this_file_path/tmp/edfi_v0_7_oea_py2.ipynb > $this_file_path/tmp/edfi_v0_7_oea_py3.ipynb
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/tmp/edfi_v0_7_oea_py3.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/utilities' --only-show-errors"

#eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_fetch_urls --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_fetch_urls.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/utilities' --only-show-errors"



eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_ingest --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_8_ingest.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_land --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_8_land.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_main_etl_pipeline --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_8_main_etl_pipeline.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_prepare_metadata --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_8_prepare_metadata.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/main' --only-show-errors"

sed "s/yourstorageaccount/$storage_account/" $this_file_path/notebook/edfi_v0_8_refine.ipynb > $this_file_path/tmp/edfi_v0_8_refine1.ipynb
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_refine --spark-pool-name spark3p4sm --file @$this_file_path/tmp/edfi_v0_8_refine1.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/main' --only-show-errors"

eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_edfi_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_8_edfi_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/utilities' --only-show-errors"

sed "s/yourstorageaccount/$storage_account/" $this_file_path/notebook/edfi_v0_8_oea_py.ipynb > $this_file_path/tmp/edfi_v0_8_oea_py1.ipynb
sed "s/yourkeyvault/$key_vault/" $this_file_path/tmp/edfi_v0_8_oea_py1.ipynb > $this_file_path/tmp/edfi_v0_8_oea_py2.ipynb
sed "s/yourtimezone/$escaped_time_zone/" $this_file_path/tmp/edfi_v0_8_oea_py2.ipynb > $this_file_path/tmp/edfi_v0_8_oea_py3.ipynb
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/tmp/edfi_v0_8_oea_py3.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/utilities' --only-show-errors"

eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_8_fetch_urls --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_8_fetch_urls.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.8/src/utilities' --only-show-errors"

# 3) setup pipelines
# Note that the ordering below matters because pipelines that are referred to by other pipelines must be created first.
#eval "az synapse pipeline create --workspace-name $synapse_workspace --name edfi_v0_7_main_etl --file @$this_file_path/pipeline/edfi_v0_7_main_etl.json"

eval "az synapse pipeline create --workspace-name $synapse_workspace --name edfi_v0_8_main_etl --file @$this_file_path/pipeline/edfi_v0_8_main_etl.json"

echo "--> Setup complete. The Ed-Fi module assets have been installed in the specified synapse workspace: $synapse_workspace"
