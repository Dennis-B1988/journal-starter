# After deploying your AWS infrastructure

* cd kubernetes
* Fix placeholder values in secrets

## Create Database table

* aws eks update-kubeconfig \
  --region us-east-1 \
  --name journal-staging-cluster <!-- Your cluster name -->

* kubectl get nodes <!-- Check if your nodes are active -->

* kubectl create configmap journal-db-init \
  --from-file=database_setup.sql \
  --dry-run=client -o yaml | kubectl apply -f -

* kubectl apply -f database-init-job.yaml
* kubectl wait --for=condition=complete job/journal-db-init --timeout=120s
* kubectl logs job/journal-db-init <!-- If everything goes right your database gets filled with the data from database_setup.sql -->

* kubectl delete -f database-init-job.yaml <!-- Delete the job after it is done -->

## Start pods and run the API

* kubectl apply -f deployment.yaml
* kubectl get pods <!-- Check if they are running -->

* kubectl port-forward deployment/journal-api 8000:8000

## Troubleshooting

* kubectl logs deployment/journal-api --tail=100

* kubectl rollout restart deployment/journal-api
* kubectl rollout status deployment/journal-api