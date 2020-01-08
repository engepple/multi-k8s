# 3 steps to finish the travis config

# Step g)
docker build -t eepple/multi-client:latest -t eepple/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eepple/multi-server:latest -t eepple/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eepple/multi-worker:latest -t eepple/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eepple/multi-client:latest
docker push eepple/multi-client:$SHA
docker push eepple/multi-server:latest
docker push eepple/multi-server:$SHA
docker push eepple/multi-worker:latest
docker push eepple/multi-worker:$SHA

#step h)
kubectl apply -f k8s

#step i)
kubectl set image deployments/server-deployment server=eepple/multi-server:$SHA
kubectl set image deployments/client-deployment client=eepple/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eepple/multi-worker:$SHA
