#!/bin/bash

# Installs the Ed-Fi module
# This script can be invoked directly to install the Ed-Fi module assets into an existing Synapse Workspace.
if [ $# -ne 1 ]; then
    echo "This setup script will install the Ed-Fi module assets into an existing Synapse workspace."
    echo "Invoke this script like this:  "
    echo "    setup.sh <synapse_workspace_name>"
    exit 1
fi

synapse_workspace=$1
this_file_path=$(dirname $(realpath $0))

echo "--> Setting up the Ed-Fi module assets."

# 2) install notebooks
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_ingest --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_ingest.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_land --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_land.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_main_etl_pipeline --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_main_etl_pipeline.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_prepare_metadata --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_prepare_metadata.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_refine --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_refine.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/main' --only-show-errors"

eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_edfi_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_edfi_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_oea_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_6_fetch_urls --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_6_fetch_urls.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.6/src/utilities' --only-show-errors"

eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_ingest --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_ingest.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_land --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_land.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_ingest --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_ingest.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_land --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_land.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_main_etl_pipeline --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_main_etl_pipeline.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_prepare_metadata --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_prepare_metadata.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_refine --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_refine.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/main' --only-show-errors"

eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_edfi_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_edfi_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_oea_py --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_oea_py.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/utilities' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edfi_v0_7_fetch_urls --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edfi_v0_7_fetch_urls.ipynb --folder-path 'OEA/modules/Ed-Fi/v0.7/src/utilities' --only-show-errors"

# 3) setup pipelines
# Note that the ordering below matters because pipelines that are referred to by other pipelines must be created first.
eval "az synapse pipeline create --workspace-name $synapse_workspace --name edfi_v0_6_main_etl --file @$this_file_path/pipeline/edfi_v0_6_main_etl.json"
eval "az synapse pipeline create --workspace-name $synapse_workspace --name edfi_v0_7_main_etl --file @$this_file_path/pipeline/edfi_v0_7_main_etl.json"

echo "--> Setup complete. The Ed-Fi module assets have been installed in the specified synapse workspace: $synapse_workspace"
