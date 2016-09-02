# jboss-eap-7.0.0 

    git clone https://github.com/Lhuckaz/sonar-ldap-docker.git
    cd sonar-ldap-docker
    
Baixar o zip ``jboss-eap-7.0.0.zip`` do site da Red Hat na mesma pasta


    docker build -t "jboss:7.0" .
    docker run -it -p 8080:8080 -p 9990:9990 --name jboss_7 jboss:7.0

    
Acessar: http://\<host\>:8080/

Para adicionar um usuario Administrador:

    docker exec -it jboss_7 ./jboss-eap-7.0/bin/add-user.sh

Acessar: http://\<host\>:9990/

