aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 579130533728.dkr.ecr.us-east-1.amazonaws.com
docker build . -t 579130533728.dkr.ecr.us-east-1.amazonaws.com/eksrepo:prod
docker push 579130533728.dkr.ecr.us-east-1.amazonaws.com/eksrepo:prod
