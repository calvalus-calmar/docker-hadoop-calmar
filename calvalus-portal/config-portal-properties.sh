#!/bin/bash

calvalusPropertiesFile=$1

function editProperty() {
  local path=$1
  local search=$2
  local replace=$3

  local escapedSearch=$(echo $search | sed 's/\//\\\//g')
  local escapedReplace=$(echo $replace | sed 's/\//\\\//g')
  sed -i "s/${escapedSearch}/${escapedReplace}/g" $path
}

search="calvalus.hadoop.fs.defaultFS = hdfs://calvalus"
replace="calvalus.hadoop.fs.defaultFS = ${CORE_CONF_fs_defaultFS}"
editProperty $calvalusPropertiesFile "$search" "$replace"

search="calvalus.hadoop.dfs.nameservices = calvalus"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.dfs.ha.namenodes.calvalus = nn1,nn2"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.dfs.namenode.rpc-address.calvalus.nn1 = master00:8020"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.dfs.namenode.rpc-address.calvalus.nn2 = master01:8020"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.dfs.client.failover.proxy.provider.calvalus = org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.mapreduce.jobhistory.address = master00:10200"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.mapreduce.jobhistory.webapp.address = master00:19888"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="#calvalus.hadoop.yarn.resourcemanager.address = master00:8032"
replace="calvalus.hadoop.yarn.resourcemanager.address = ${YARN_CONF_yarn_resourcemanager_address}"
editProperty $calvalusPropertiesFile "$search" "$replace"

search="calvalus.hadoop.calvalus.snap.bundle = snap-5-cv-2.14"
replace="calvalus.hadoop.calvalus.snap.bundle = $SNAP"
editProperty $calvalusPropertiesFile "$search" "$replace"

search="#calvalus.hadoop.yarn.resourcemanager.hostname = master00"
replace="calvalus.hadoop.yarn.resourcemanager.hostname = ${YARN_CONF_yarn_resourcemanager_hostname}"
editProperty $calvalusPropertiesFile "$search" "$replace"

search="calvalus.hadoop.yarn.resourcemanager.ha.enabled = true"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.yarn.resourcemanager.ha.rm-ids = rm1,rm2"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.yarn.resourcemanager.hostname = master00"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.yarn.resourcemanager.hostname.rm1 = master00"
editProperty $calvalusPropertiesFile "$search" "#$search"

search="calvalus.hadoop.yarn.resourcemanager.hostname.rm2 = master01"
editProperty $calvalusPropertiesFile "$search" "#$search"

#search="calvalus.ql.upload.URL = http:\\localhost:8080\geoserver\rest"
#replace="calvalus.ql.upload.URL = http:\\myhost:8080\geoserver\rest"
#editProperty $calvalusPropertiesFile "$search" "$replace"

#search="calvalus.hadoop.mapreduce.task.timeout = 600000"
#replace="calvalus.hadoop.mapreduce.task.timeout = 1800000"
#editProperty $calvalusPropertiesFile "$search" "$replace"
