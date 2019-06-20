#/bin/bash
set -e

NAMESPACE=$1

kubectl delete secret tinjis-secret || true
CREATE_SECRET_COMMAND="kubectl create secret generic tinjis-secret "
while read line;
do CREATE_SECRET_COMMAND+=" --from-literal=$line" ; done < kubernetes/parameters/test/secrets.env
CREATE_SECRET_COMMAND+=" -n=${NAMESPACE}"
echo $CREATE_SECRET_COMMAND
eval "$CREATE_SECRET_COMMAND"
kubectl  apply -f kubernetes/parameters/test/params.yaml -n=${NAMESPACE}
kubectl  apply -f kubernetes/templates/test/tinjis.yaml -n=${NAMESPACE}
docker build -t viallikavoo/tinjis .
docker push viallikavoo/tinjis:latest
