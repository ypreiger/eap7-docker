# Pull base image
FROM registry.access.redhat.com/jboss-eap-7/eap70-openshift

# Maintainer
MAINTAINER YP

# deploy app
ADD ticket-monster.war $JBOSS_HOME/standalone/deployments/
ADD standalone-openshift.xml $JBOSS_HOME/standalone/configuration

USER root
# In the JBoss EAP container, JBoss EAP runs as the jboss user
# but copied files are brought in as root
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/product.war
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-openshift.xml
USER jboss

# Expose the ports 
EXPOSE 8080 9990 4447 9999

# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-eap-7.0/bin/domain.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
