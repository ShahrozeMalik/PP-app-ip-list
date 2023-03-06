# PP-app-ip-list
This app saves the public IP it was hit from and then shows all of them on /list path
- APP URL http://af24475d4431e44f1939cfed76fe86e5-1279671914.us-east-1.elb.amazonaws.com/
- Save your public IP http://af24475d4431e44f1939cfed76fe86e5-1279671914.us-east-1.elb.amazonaws.com/client-ip
- Show all public IPs http://af24475d4431e44f1939cfed76fe86e5-1279671914.us-east-1.elb.amazonaws.com/client-ip/list 

## App

- The backend code of the app is in nodejs and can be found in app/ folder.
- To build and push the latest code run build.sh in app/ folder.

## Kubernetes

- The kubernetes manifests of the app is in kube/ folder.
- To deploy to kubernetes, just run kubectl apply -f kube/.

## Terraform

- The terraform code we used here is using a modular approach.
- We are creating EKS, RDS, VPC, SG, ROLES and ECR.
- To deploy the code simply run terraform apply --var-file="./cofiguration/dev.tfvar"


