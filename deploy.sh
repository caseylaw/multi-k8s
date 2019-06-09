docker build -t caseylaw/multi-client:latest -t caseylaw/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t caseylaw/multi-server:latest -t caseylaw/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t caseylaw/multi-worker:latest -t caseylaw/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push caseylaw/multi-client:latest
docker push caseylaw/multi-server:latest
docker push caseylaw/multi-worker:latest

docker push caseylaw/multi-client:$SHA
docker push caseylaw/multi-server:$SHA
docker push caseylaw/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=caseylaw/multi-server:$SHA
kubectl set image deployments/client-deployment client=caseylaw/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=caseylaw/multi-worker:$SHA