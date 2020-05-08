docker build -t agamblin/multi-client:latest -t agamblin/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t agamblin/multi-server:latest -t agamblin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t agamblin/multi-worker:latest -t agamblin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push agamblin/multi-client:latest
docker push agamblin/multi-server:latest
docker push agamblin/multi-worker:latest

docker push agamblin/multi-client:$SHA
docker push agamblin/multi-server:$SHA
docker push agamblin/multi-worker:$SHA

kubectl apply -f k8s
kuebctl set image deployments/server-deployment server=agamblin/multi-server:$SHA
kuebctl set image deployments/client-deployment client=agamblin/multi-client:$SHA
kuebctl set image deployments/worker-deployment worker=agamblin/multi-worker:$SHA