# jboss-eap-7.0.0-docker

docker build -t eap70-custom:1.0 https://raw.githubusercontent.com/ypreiger/eap7-docker/master/base/Dockerfile
# docker tag eap70-custom:1.0 eap70-custom:latest
docker push docker-registry-default.apps.ocp.mydomain.rh:5000/inventory/eap70-custom:latest

    
Acessar: http://\<host\>:8080/

Para adicionar um usuario Administrador:

    docker exec -it jboss_7 ./jboss-eap-7.0/bin/add-user.sh

Acessar: http://\<host\>:9990/

