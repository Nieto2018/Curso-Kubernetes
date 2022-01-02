aws eks describe-cluster --name test-cluster --query "cluster.identity.oidc.issuer" --output text
> https://oidc.eks.us-east-1.amazonaws.com/id/EE92B106C488C3982F1394C1957FE758

aws iam list-open-id-connect-providers | grep EE92B106C488C3982F1394C1957FE758
> "Arn": "arn:aws:iam::898493283539:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EE92B106C488C3982F1394C1957FE758"

# ---------------------------------------------

aws iam create-policy \
    --policy-name AmazonEKSClusterAutoscalerPolicy \
    --policy-document file://cluster-autoscaler-policy.json
> 
  {
      "Policy": {
          "PolicyName": "AmazonEKSClusterAutoscalerPolicy",
          "PolicyId": "ANPA5CMS7PTJ2B4SAESVT",
          "Arn": "arn:aws:iam::898493283539:policy/AmazonEKSClusterAutoscalerPolicy",
          "Path": "/",
          "DefaultVersionId": "v1",
          "AttachmentCount": 0,
          "PermissionsBoundaryUsageCount": 0,
          "IsAttachable": true,
          "CreateDate": "2022-01-02T12:12:18+00:00",
          "UpdateDate": "2022-01-02T12:12:18+00:00"
      }
  }


eksctl create iamserviceaccount \
  --cluster=test-cluster \
  --namespace=kube-system \
  --name=cluster-autoscaler \
  --attach-policy-arn=arn:aws:iam::898493283539:policy/AmazonEKSClusterAutoscalerPolicy \
  --override-existing-serviceaccounts \
  --approve

kubectl annotate serviceaccount cluster-autoscaler \
  -n kube-system \
  eks.amazonaws.com/role-arn=arn:aws:iam::898493283539:role/eksctl-test-cluster-nodegroup-tes-NodeInstanceRole-16RL3OM9REARW

kubectl annotate serviceaccount cluster-autoscaler \
  -n kube-system \
  eks.amazonaws.com/role-arn=arn:aws:iam::898493283539:role/AWSServiceRoleForAutoScaling

kubectl set image deployment cluster-autoscaler \
  -n kube-system \
  cluster-autoscaler=k8s.gcr.io/autoscaling/cluster-autoscaler:v1.21.2

  0102 12:31:31.394312       1 aws_manager.go:265] Failed to regenerate ASG cache: cannot autodiscover ASGs: WebIdentityErr: failed to retrieve credentials
caused by: AccessDenied: Not authorized to perform sts:AssumeRoleWithWebIdentity
	status code: 403, request id: 59c595b8-87d1-40a8-9797-a6e71836b439
F0102 12:31:31.394342       1 aws_cloud_provider.go:389] Failed to create AWS Manager: cannot autodiscover ASGs: WebIdentityErr: failed to retrieve credentials
caused by: AccessDenied: Not authorized to perform sts:AssumeRoleWithWebIdentity
	status code: 403, request id: 59c595b8-87d1-40a8-9797-a6e71836b439
goroutine 65 [running]:
