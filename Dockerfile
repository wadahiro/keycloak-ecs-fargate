FROM jboss/keycloak:3.4.1.Final

USER root
RUN yum install -y iproute
USER jboss

ADD cli/* /opt/jboss/keycloak/cli/
RUN cd /opt/jboss/keycloak \
  && bin/jboss-cli.sh --file=cli/aws.cli \
  && rm -rf /opt/jboss/keycloak/standalone/configuration/standalone_xml_history

RUN sed -i -e "/.*<\/dependencies>$/i \ \ \ \ \ \ \ \ <module name=\"com.mysql.jdbc\"\/>" /opt/jboss/keycloak/modules/system/layers/base/org/jgroups/main/module.xml

ADD docker-entrypoint-aws.sh /opt/jboss/

ENTRYPOINT [ "/opt/jboss/docker-entrypoint-aws.sh" ]
CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml"]

EXPOSE 7600
EXPOSE 57600

