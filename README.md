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

./setup.sh -o 'vcsprod' -r 'edgraph-rg' -l 'eastus'

```
