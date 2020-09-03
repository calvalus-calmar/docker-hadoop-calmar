#!/bin/bash

# setup tomcat user for calvalus-portal
/config-tomcat-users.sh conf/tomcat-users.xml

# extract calvalus-portal war file
mkdir calvalus-portal
cd calvalus-portal
jar xf ../calvalus-portal.war
cd ..

# configure calvalus-portal war file
/config-portal-properties.sh calvalus-portal/config/calvalus.properties
/config-portal-palettes.sh calvalus-portal/WEB-INF/classes/com/bc/calvalus/portal/server/color-palettes.properties

/config-user-palettes.sh
/config-user-regions.sh

# deploy configured calvalus-portal to webapp for deployment
mv calvalus-portal /usr/local/tomcat/webapps/

# start tomcat
catalina.sh run
