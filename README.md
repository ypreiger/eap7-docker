# jboss-eap-7.0.0-docker

docker build -t eap70-custom:1.0 https://raw.githubusercontent.com/ypreiger/eap7-docker/master/app/Dockerfile
# docker tag eap70-custom:1.0 eap70-custom:latest
docker push 172.30.172.155:5000/inventory/eap70-custom:1:0

    
Acessar: http://\<host\>:8080/

Para adicionar um usuario Administrador:

    docker exec -it jboss_7 ./jboss-eap-7.0/bin/add-user.sh

Acessar: http://\<host\>:9990/

