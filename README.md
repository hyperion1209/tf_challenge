# Terraform Challenge
Your mission is to spot potential issues and suggest enhancements

## Original code
https://gist.github.com/aduis/5daaaa3ad69f6f1b6d4ae660f80d0d86

## Comments to look out for
- CHECK: verify assumptions
- ADDED: resources added to existing code
- CHANGED: changes made to existing code with the previous version commented out

## Change log
- Added S3 backend configuration to store the state file in an S3 bucket and to enable locking with DynamoDB
- Changed the custome_cluster_identifier variable so that it's based on the TF workspace.
- Added separate file for locals definitions
- Added separate file for variable definitions
- Added separate file for provider configuration
- Changed PVC cleam template to use ReadWriteMany access mode in order to allow multiple pods to read and write to the same volume

## Assumptions
- The AWS CLI is installed and configured
- AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY or AWS_SESSION_TOKEN are set
- The EKS cluster is deployed across multiple availability zones for the anti-affinity rule to work

## Suggestions
- Define a storage class for the PVC, otherwise the default AWS storage class (gp2) will be used
