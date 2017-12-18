FROM jboss/keycloak:3.4.1.Final

CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml"]

ADD cli/* /opt/jboss/keycloak/cli/
RUN cd /opt/jboss/keycloak \
  && bin/jboss-cli.sh --file=cli/aws.cli \
  && rm -rf /opt/jboss/keycloak/standalone/configuration/standalone_xml_history

RUN sed -i -e "/.*<\/dependencies>$/i \ \ \ \ \ \ \ \ <module name=\"com.mysql\"\/>" /opt/jboss/keycloak/modules/system/layers/base/org/jgroups/main/module.xml

EXPOSE 7600
EXPOSE 57600
