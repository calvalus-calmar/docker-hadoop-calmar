#!/bin/bash

tomcatUsersFile=$1
username=${CORE_CONF_hadoop_http_staticuser_user}
comment='<!-- Calvalus portal roles and users -->'

if ! grep -q "${comment}" tomcat-users.xml; then
  sed -i "/<\/tomcat-users>/ i \
  \  $comment\n\
  <role rolename=\"calvalus\"/>\n\
  <role rolename=\"bc\"/>\n\
  <user username=\"${username}\" password=\"demo\" roles=\"calvalus,bc\"/>" \
  $tomcatUsersFile
fi
