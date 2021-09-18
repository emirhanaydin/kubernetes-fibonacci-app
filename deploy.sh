docker build \
  -t emirhanaydin/fibonacci-app-client:latest \
  -t emirhanaydin/fibonacci-app-client:"$WEB_GIT_SHA" \
  -f ./web/Dockerfile ./web
docker build \
  -t emirhanaydin/fibonacci-app-api:latest \
  -t emirhanaydin/fibonacci-app-api:"$API_GIT_SHA" \
  -f ./api/Dockerfile ./api
docker build \
  -t emirhanaydin/fibonacci-app-worker:latest \
  -t emirhanaydin/fibonacci-app-worker:"$WORKER_GIT_SHA" \
  -f ./worker/Dockerfile ./worker

docker push emirhanaydin/fibonacci-app-client:latest
docker push emirhanaydin/fibonacci-app-client:"$WEB_GIT_SHA"
docker push emirhanaydin/fibonacci-app-api:latest
docker push emirhanaydin/fibonacci-app-api:"$API_GIT_SHA"
docker push emirhanaydin/fibonacci-app-worker:latest
docker push emirhanaydin/fibonacci-app-worker:"$WORKER_GIT_SHA"

kubectl apply -f ./k8s/

kubectl rollout restart -f ./k8s/web-deployment.yml
kubectl rollout restart -f ./k8s/api-deployment.yml
kubectl rollout restart -f ./k8s/worker-deployment.yml
