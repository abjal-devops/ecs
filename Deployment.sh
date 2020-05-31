#aws ecr get-login --region us-east-1 --no-include-email > ecr-login.sh
#sh ecr-login.sh
docker build -t 470859871030.dkr.ecr.us-east-1.amazonaws.com/test:${BUILD_ID} .
docker push 470859871030.dkr.ecr.us-east-1.amazonaws.com/test:${BUILD_ID}
image=470859871030.dkr.ecr.us-east-1.amazonaws.com/test:${BUILD_ID}
sed -i 's#image_name#'"${image}"'#' TD-nginx.json
aws ecs register-task-definition --family nginx --cli-input-json file://TD-nginx.json --region us-east-1
#aws ecs create-service --service-name nginx --launch-type EC2 --desired-count 1 --task-definition nginx --cluster test --region us-east-1
REVISION=`aws ecs describe-task-definition --task-definition nginx --region us-east-1 |jq .taskDefinition.revision`
for task in $(aws ecs list-tasks --cluster test --family nginx| jq -r '.taskArns[]'); do
done
aws ecs update-service --region us-east-1 --service nginx --task-definition nginx:$REVISION --cluster test --desired-count 1 --force-new-deployment
