provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.cluster.id]
      command     = "aws"
    }
  }
}

resource "helm_release" "metrics-server" {
  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.11.0"

  set {
    name  = "metrics.enabled"
    value = false
  }

  set {
    name = "image.repository"
    value = "739999085319.dkr.ecr.ap-northeast-2.amazonaws.com/metric-server"
  }

  set {
    name = "image.tag"
    value = "v0.6.4"
  }

  depends_on = [aws_eks_fargate_profile.kube-system]
}
