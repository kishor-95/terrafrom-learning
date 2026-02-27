During the migration process, several resources were created under the AWS account. Some of these test resources are no longer needed at the moment, so we need to clean them up temporarily. One such instance is currently unused and should be deleted.

1) Delete the ec2 instance named devops-ec2 present in us-east-1 region using terraform. Make sure to keep the provisioning code, as we might need to provision this instance again later.

2) Before submitting your task, make sure instance is in terminated state.

The Terraform working directory is /home/bob/terraform.



## 

Check the current state file status

terraform state list 

terraform state list --> Output
aws_instance.ec2
