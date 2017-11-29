# Pull base image
FROM registry.access.redhat.com/jboss-eap-7/eap70-openshift

# Maintainer
MAINTAINER YP

# deploy app
ADD product.war $JBOSS_HOME/standalone/deployments/
ADD standalone-openshift.xml $JBOSS_HOME/standalone/configuration

USER root
# In the JBoss EAP container, JBoss EAP runs as the jboss user
# but copied files are brought in as root
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/product.war
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-openshift.xml
USER jboss

