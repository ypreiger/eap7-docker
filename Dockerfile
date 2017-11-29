FROM registry.access.redhat.com/jboss-eap-7/eap70-openshift
MAINTAINER YP

ENV APP_NAME=leasy-hello-service
ENV JBOSS_HOME=/opt/jboss
ENV JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
 
# WILY install
ENV WILY_PARAMETERS=-Djavaagent:/home/jboss/wily/wily_10.5.2/Agent.jar -Dcom.wily.introscope.agentProfile=/home/jboss/wily/wily_10.5.2/core/config/IntroscopeAgent.${APP_NAME}.profile -Dcom.wily.introscope.agent.agentName=${APP_NAME}
USER root

RUN mkdir -p wily

RUN yum --disablerepo="jboss-rhel-ose"  install ksh -y
RUN yum repolist

ADD http://nexus3-cicd.openshift.garanti.com.tr/repository/images/wily.tar /home/jboss/wily/
RUN ls /home/jboss/wily
RUN cd /home/jboss/wily
RUN tar -xvf /home/jboss/wily/wily.tar \
&& rm /home/jboss/wily/wily.tar
RUN ls /home/jboss/wily
RUN chown -R jboss /home/jboss/wily

ADD http://gogs-cicd.openshift.garanti.com.tr/garanti-leasing/workshop02/raw/master/standalone/standalone.conf opt/eap/bin/standalone.conf
ADD http://10.145.3.107:8081/nexus/content/repositories/snapshots/com/garantileasing/leasy-hello-api/0.0.1-SNAPSHOT/leasy-hello-api-0.0.1-20171025.200728-1.war  /home/jboss/source/deployments/ROOT.war
RUN chown -R jboss:jboss /home/jboss/

RUN cat /home/jboss/wily/wily_10.5.2/core/config/IntroscopeAgent.Template.profile|sed "s/Template/${APP_NAME}/g" >> /home/jboss/wily/wily_10.5.2/core/config/IntroscopeAgent.${APP_NAME}.profile
RUN cp /home/jboss/wily/wily_10.5.2/core/config/Template.pbd /home/jboss/wily/wily_10.5.2/core/config/${APP_NAME}.pbd
RUN chown jboss:jboss /home/jboss/wily/wily_10.5.2/core/config/IntroscopeAgent.${APP_NAME}.profile /home/jboss/wily/wily_10.5.2/core/config/${APP_NAME}.pbd

USER jboss

# ??? IS THIS NEEDED?
RUN  $JBOSS_CLI -c ":shutdown"
# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# ??? IS THIS NEEDED?
# Expose the ports we're interested in
# http://stackoverflow.com/a/32213512/1098564
EXPOSE 8080 9990 4447 9999

# ??? IS THIS NEEDED?
# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-eap-7.0/bin/domain.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

# ??? DO I NEED MODIFY ASSEMBLY SCRIPT?
# ??? follow https://github.com/rafabene/devops-demo/tree/master/Dockerfiles/ticketmonster
