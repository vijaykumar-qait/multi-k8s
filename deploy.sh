docker build -t vijaykumar23/multi-client:latest -t vijaykumar23/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vijaykumar23/multi-server:latest -t vijaykumar23/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vijaykumar23/multi-worker:latest -t vijaykumar23/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vijaykumar23/multi-client:latest
docker push vijaykumar23/multi-server:latest
docker push vijaykumar23/multi-worker:latest

docker push vijaykumar23/multi-client:$SHA
docker push vijaykumar23/multi-server:$SHA
docker push vijaykumar23/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vijaykumar23/multi-server:$SHA
kubectl set image deployments/client-deployment client=vijaykumar23/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vijaykumar23/multi-worker:$SHA