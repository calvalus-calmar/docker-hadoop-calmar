FROM tomcat:9.0-jdk8-openjdk

LABEL Description="This image is used to start the Calvalus portal" Maintainer="Declan Dunne"

COPY --from=calvalusmarine/calvalus-base:master /calvalus/calvalus2/calvalus-portal/target/calvalus-portal.war .

ADD config-tomcat-users.sh /config-tomcat-users.sh
ADD config-portal-properties.sh /config-portal-properties.sh
ADD config-portal-palettes.sh /config-portal-palettes.sh

ADD config-user-palettes.sh /config-user-palettes.sh
ADD config-user-regions.sh /config-user-regions.sh

ADD run.sh /run.sh

RUN chmod a+x /config-tomcat-users.sh \
      /config-portal-properties.sh /config-portal-palettes.sh \
      /config-user-palettes.sh /config-user-regions.sh \
      /run.sh

CMD ["/run.sh"]
