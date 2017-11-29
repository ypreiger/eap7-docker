#!/bin/sh

##  Restart Jboss eap 

JAVA_HOME="$(find /usr/lib/jvm/java-1.8.0* -type f -name javac | tail -n 1 | xargs  dirname)"
PATH="${JAVA_HOME}/bin:${PATH}"


function StartJB {
  if [ -z "$type" ]; then
    type="standalone"
  fi   
  JBOSS_HOME="$(find /apps/jboss/ -maxdepth 1 | tail -1)"
  ${JBOSS_HOME}/bin/${type}.sh -b 0.0.0.0 -bmanagement 0.0.0.0
  tail -f /tmp/eap-build/work/build.log
}

# if [ <running server> ]; then
#  kill JB
# else
  StartJB
#fi
