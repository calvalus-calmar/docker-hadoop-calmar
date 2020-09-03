#!/bin/bash
# Add custom user regions

USERNAME=${CORE_CONF_hadoop_http_staticuser_user}
FILE=${USERNAME}-regions.properties
DIRECTORY=/${USERNAME}/.calvalus/

if [ ! -d "$DIRECTORY" ]
then
  mkdir ${DIRECTORY}
fi

cat > ${DIRECTORY}${FILE} << EOF
# Register user '${USERNAME}' regions for calvalus portal
#
# Example entry registering extents for Ireland
#user.Ireland=POLYGON((-5.0 56.0, -5.0 51.0, -11.0 51.0, -11.0 56.0, -5.0 56.0))
EOF
