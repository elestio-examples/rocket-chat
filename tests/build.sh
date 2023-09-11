cp -r 6.2/* ./
chmox +x ./init.sh
chmox +x ./init2.sh
rm -f composer.yml
docker buildx build . --output type=docker,name=elestio4test/rocket-chat:latest | docker load
