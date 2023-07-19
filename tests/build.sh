cp -r ./6.2/* ./
docker buildx build . --output type=docker,name=elestio4test/rocket.chat:latest | docker load