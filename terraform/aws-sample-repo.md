site
https://github.com/orgs/aws-samples/repositories?
https://github.com/orgs/aws-samples/repositories?

SECURITY

1. Service Control Policy with Terraform
https://github.com/aws-samples/aws-scps-with-terraform
Service control policies (SCPs) are a type of organization policy that you can use to manage permissions in your organization. SCPs offer central control over the maximum available permissions for the IAM users and IAM roles in your organization.
https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html

2. Safeguarding payments code -  s3, vpc
https://github.com/aws-samples/safeguarding-payments-fraud-detection-ai-ml-and-data-insights/blob/main/iac/core/s3_runtime/main.tf

3. AWS Security Reference Architecture Examples
https://github.com/aws-samples/aws-security-reference-architecture-examples/blob/main/README.md

4. ANALYSING WAF TRAFFIC WITH ATHENA
Analyzing AWS WAF logs using Amazon Athena queries provides visibility needed for threat detection.
https://aws.amazon.com/athena/
https://github.com/aws-samples/waf-log-sample-athena-queries/tree/main?tab=readme-ov-file

5. Sample React App Using ABAC + Identity Pools to access AWS resources
https://github.com/aws-samples/amazon-cognito-abac-authorization-with-react-example

6. Findings Reporter for Amazon Inspector
https://github.com/aws-samples/findings-reporter-for-amazon-inspector

7. AWS Serverless Developer Experience workshop reference architecture (Python)
https://github.com/aws-samples/aws-serverless-developer-experience-workshop-python/tree/develop

8. Terraform RAG template with Amazon Bedrock
https://github.com/aws-samples/terraform-rag-template-using-amazon-bedrock
This repository contains a Terraform implementation of a simple Retrieval-Augmented Generation (RAG) use case using Amazon Titan V2 as the embedding model and Claude 3 as the text generation model, both on Amazon Bedrock. This sample follows the user journey described below:

The user manually uploads a file to Amazon S3, such as a Microsoft Excel or PDF document. The supported file types can be found here.
The content of the file is extracted and embedded into a knowledge database based on a serverless Amazon Aurora with PostgreSQL.
When the user engages with the text generation model, it utilizes previously uploaded files to enhance the interaction through retrieval augmentation.

9. AWS IAM Access Analyzer CheckNoNewAccess Sample Reference Policies
https://github.com/aws-samples/iam-access-analyzer-custom-policy-check-samples
This repository contains a collection of sample reference policies that can be used with the Access Analyzer's CheckNoNewAccess API. The CheckNoNewAccess API checks an existing policy against a new policy and returns PASS if no new access is detected in the new policy and FAIL if new access is detected in the new policy.

10. Ingest AWS SECURITY LOGS IN MS SENTINEL
https://github.com/aws-samples/ingest-and-analyze-aws-security-logs-in-microsoft-sentinel

11. lAMBDA - Generating simulated security findings in your AWS account gives your security team an opportunity to validate their cyber capabilities, investigation workflow and playbooks, escalation paths across teams, and exercise any response automation currently in place.
https://github.com/aws-samples/generate-aws-security-services-findings

12. GENERATE SCORE
https://github.com/aws-samples/aws-securityhub-score-generator/blob/main/scoreGenerator.py

13. Policy-as-Code
This repo contains Open Policy Agent (OPA) policies to test AWS infrastructure against terraform plan.
https://github.com/aws-samples/aws-infra-policy-as-code-with-terraform/tree/main
github actions for opa install
https://github.com/aws-samples/aws-infra-policy-as-code-with-terraform/blob/main/.github/workflows/coverage.yaml

APIGATEWAY
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api

14. Elevate API Security with Cognito and WAF
https://github.com/aws-samples/elevate-api-security-with-cognito-and-waf?tab=readme-ov-file

15. Use Terraform to automatically enable Amazon GuardDuty for an organization
https://github.com/aws-samples/amazon-guardduty-for-aws-organizations-with-terraform

16. Enhance Amazon CloudFront Origin Security with AWS WAF and AWS Secrets Manager
https://github.com/aws-samples/amazon-cloudfront-waf-secretsmanager
Python lambda
https://github.com/aws-samples/amazon-cloudfront-waf-secretsmanager/blob/master/lambda/lambda_function.py

17. Virtual SOC with MITRE Attack integration with AWS Security Hub example
https://github.com/aws-samples/mitre-attack-with-aws-security-hub-example

18. aws-security-hub-csv-manager-Lambda
https://github.com/aws-samples/aws-security-hub-csv-manager/blob/main/csv_manager_sechub_cdk/lambdas/csvExporter.py
https://github.com/aws-samples/aws-security-hub-csv-manager/tree/main

19. Amazon CloudFront Signed URLs using Lambda and Secrets Manager
Important Update: Amazon CloudFront announces support for public key management through IAM user permissions for signed URLs and signed cookies

In this example we provide step-by-step instructions to create Amazon CloudFront Signed URLs with both canned and custom policies using:

AWS Lambda as the execution tool
AWS Secrets Manager to manage the private signing key for security best practices
Amazon S3 as a restricted content source
https://github.com/aws-samples/amazon-cloudfront-signed-urls-using-lambda-secretsmanager?tab=readme-ov-file

20. aws-security-hub-glue-aggregator
Code to deploy a solution to aggregate the findings from Security Hub from different accounts to a centralized account using Amazon Kinesis Data Firehose and AWS Glue
https://github.com/aws-samples/aws-security-hub-glue-aggregator-terraform

21. This repo contains the source for both the content and examples for the Policy as Code Workshop. Refer to the Getting Started guide for details.
https://github.com/aws-samples/policy-as-code/tree/main?tab=readme-ov-file

22. CloudFront update Terraform sample
https://github.com/aws-samples/aws-cloudfront-automation-terraform-samples/tree/main
\
23. AWS WAF Automation Using Terraform -- APIGATEWAY
WAF Automation on AWS solution is developed using Terraform which automatically deploys a set of AWS WAF rules that filter common web-based attacks. Users can select from preconfigured protective features that define the rules included in an AWS WAF web access control list (web ACL). Once deployed, AWS WAF protects your Amazon CloudFront distributions or Application Load Balancers by inspecting web requests.
https://github.com/aws-samples/aws-waf-automation-terraform-samples/blob/main/README.md

24. AWS WAF Terraform artifacts
Check documentation under the folder /documentation.

Introduction
The intention of this document is to provide a clear documentation about the artifacts created to deploy AWS WAF and its configuration using Terraform as IaC provider.
https://github.com/aws-samples/aws-waf-firewall-manager-terraform/tree/main

25. sample make files
https://github.com/aws-samples/aws-serverless-ecommerce-platform/blob/main/frontend-api/Makefile

26. APIGATEWAY TERRAFORM
Amazon API Gateway Deployment Lifecycle Management via Terraform
Maintaining a comprehensive deployment history is crucial for ensuring the ability to revert to prior versions when necessary or assign different API stages to different API deployments. This ensures that you can smoothly transition between different states of your infrastructure.

This project provides a steps by step guide and reusable sample code to deploy and manage API deployments and API stages of an Amazon API Gateway via Terraform. By using this solution, the history of API deployment will be maintain and will be possible to assign different stages or rollback to previous versions. This overcomes the problem that, by default, Terraform considers deployments as resources and so at every change only the last deployment will be maintain
https://github.com/aws-samples/apigateway-deployment-lifecycle-management-terraform

27. Using AWS Module for s3 static website
https://github.com/tal-rofe/url-shortener/blob/main/terraform/modules/ssl-static-app/s3.tf
https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/tree/master/modules

28. Lambda Sample - AD Cleanup
https://github.com/aws-samples/aws-lambda-ad-cleanup-terraform-samples/tree/main

28. AWS COGNITO LAMBDA EDGE WITH CLOUDFRONT
https://github.com/aws-samples/cloudfront-authorization-at-edge?tab=readme-ov-file