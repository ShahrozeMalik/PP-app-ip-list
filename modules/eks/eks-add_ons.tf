# # resource "helm_release" "example" {
# #   name       = "my-local-chart"
# #   chart      = "./flask-mysql-helmchart"

# #   set {
# #     value = var.rds_output.db
# #     name = "db.endpoint"
# #   }
# # }
# # # resource "helm_release" "nginx_ingress" {
# # #   name       = "nginx-ingress-controller"

# # #   repository = "https://charts.bitnami.com/bitnami"
# # #   chart      = "nginx-ingress-controller"

# # #   set {
# # #     name  = "service.type"
# # #     value = "ClusterIP"
# # #   }
# # # }
# resource "helm_release" "dashboard" {

#   create_namespace = false
#   repository       = "https://kubernetes.github.io/dashboard/"
#   namespace        = "default"
#   version          = "5.10.0"
#   chart            = "kubernetes-dashboard"
#   name             = "dashboard"
# }