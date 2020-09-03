#!/bin/bash
# Add custom user palettes

USERNAME=${CORE_CONF_hadoop_http_staticuser_user}
FILE=${USERNAME}-color-palettes.properties
DIRECTORY=/${USERNAME}/.calvalus/
FILE_SYSTEM_HOST=${CORE_CONF_fs_defaultFS}

if [ ! -d "$DIRECTORY" ]
then
  mkdir ${DIRECTORY}
fi

cat > ${DIRECTORY}${FILE} << EOF
# Register user '${USERNAME}' color palettes for calvalus portal
#
# Example entry registering sar.cpd
#sar = $FILE_SYSTEM_HOST/calvalus/auxiliary/cpd/sar.cpd
EOF
