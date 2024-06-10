#!/bin/bash

# Installs the EdGraph_DW module
# This script can be invoked directly to install the EdGraph_DW module assets into an existing Synapse Workspace.
if [ $# -ne 1 ]; then
    echo "This setup script will install the EdGraph_DW module assets into an existing Synapse workspace."
    echo "Invoke this script like this:  "
    echo "    setup.sh <synapse_workspace_name>"
    exit 1
fi

synapse_workspace=$1
this_file_path=$(dirname $(realpath $0))

echo "--> Setting up the EdGraph_DW module assets."

# 2) install notebooks

#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_freq_etl_metadata --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_freq_etl_metadata.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_main_etl_pipeline --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_main_etl_pipeline.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_migrate_to_stage3 --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_migrate_to_stage3.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_populate_sql_db --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_populate_sql_db.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_s2r_descriptor_views --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_s2r_descriptor_views.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_semantic_views --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_semantic_views.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/main' --only-show-errors"
#eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_6_dw_builder --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_6_dw_builder.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.6/src/utilities' --only-show-errors"

eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_freq_etl_metadata --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_freq_etl_metadata.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_main_etl_pipeline --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_main_etl_pipeline.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_migrate_to_stage3 --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_migrate_to_stage3.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_populate_sql_db --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_populate_sql_db.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_s2r_descriptor_views --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_s2r_descriptor_views.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_semantic_views --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_semantic_views.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/main' --only-show-errors"
eval "az synapse notebook import --workspace-name $synapse_workspace --name edgraph_dw_v0_7_dw_builder --spark-pool-name spark3p4sm --file @$this_file_path/notebook/edgraph_dw_v0_7_dw_builder.ipynb --folder-path 'EdGraph/modules/EdGraph_DW/v0.7/src/utilities' --only-show-errors"

# 3) setup pipelines
# Note that the ordering below matters because pipelines that are referred to by other pipelines must be created first.
#eval "az synapse pipeline create --workspace-name $synapse_workspace --name edgraph_dw_v0_5_main_etl --file @$this_file_path/pipeline/edgraph_dw_v0_5_main_etl.json" 
#eval "az synapse pipeline create --workspace-name $synapse_workspace --name edgraph_dw_v0_6_main_etl --file @$this_file_path/pipeline/edgraph_dw_v0_6_main_etl.json" 
eval "az synapse pipeline create --workspace-name $synapse_workspace --name edgraph_dw_v0_7_main_etl --file @$this_file_path/pipeline/edgraph_dw_v0_7_main_etl.json" 

echo "--> Setup complete. The EdGraph_DW module assets have been installed in the specified synapse workspace: $synapse_workspace"
