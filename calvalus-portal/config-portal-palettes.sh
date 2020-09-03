#!/bin/bash

colorPalettesPropertiesFile=$1

function editProperty() {
  local path=$1
  local search=$2
  local replace=$3

  local escapedSearch=$(echo $search | sed 's/\//\\\//g')
  local escapedReplace=$(echo $replace | sed 's/\//\\\//g')
  sed -i "s/${escapedSearch}/${escapedReplace}/g" $path
}

search="hdfs://master00:9000"
replace=$CORE_CONF_fs_defaultFS
editProperty $colorPalettesPropertiesFile $search $replace
