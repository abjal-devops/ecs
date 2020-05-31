ECR_REPO_URL=
ass ecr get-login --region us-east-1 --no-include-email > ecr-login.sh
sh ecr-login.sh
docker build -t &ECR_REPO_URL:&BUILD_ID
