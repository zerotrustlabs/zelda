# Integrate GitHub Actions with HCP Terraform
https://developer.hashicorp.com/terraform/tutorials/automation/github-actions

This tutorial will guide you through setting up a GitHub Action that connects to HCP Terraform to plan and apply your configuration.

## Prerequisites

Before you begin, ensure you have completed the following:

1. **Familiarity with Terraform and HCP Terraform**:
   - If you are new to Terraform, complete the [Get Started with Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started) tutorials.
   - If you are new to HCP Terraform, complete the [HCP Terraform Get Started](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started) tutorials.

2. **Requirements**:
   - An HCP Terraform workspace.
   - AWS credentials for the workspace.
   - An HCP Terraform user API token.

## Set Up HCP Terraform

Follow these steps to set up HCP Terraform for integration with GitHub Actions:

### Step 1: Create a New HCP Terraform Workspace

1. Navigate to the [Create a new Workspace](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions) page.
2. Select **API-driven workflow**.
3. Name your workspace `learn-terraform-github-actions`.
4. Click **Create workspace**.

### Step 2: Add AWS Credentials

1. Find the AWS credentials you want to use for the workspace. Alternatively, create a new key pair in the IAM console.
2. Add the following as Environment Variables for your `learn-terraform-github-actions` workspace:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

### Step 3: Generate an HCP Terraform User API Token

1. Go to the **Tokens** page in your HCP Terraform User Settings.
2. Click on **Create an API token**.
3. Enter `GitHub Actions` for the Description.
4. Click **Generate token**.

By completing these steps, you will have prepared your HCP Terraform workspace for integration with GitHub Actions.

## Resources

For more detailed information, refer to the following resources:
- [Terraform's official documentation](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)
- [Get Started with Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
- [HCP Terraform Get Started](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started)

