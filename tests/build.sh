cp -r apps/meteor/.docker/* ./
docker buildx build . --output type=docker,name=elestio4test/rocket.chat:latest | docker load
