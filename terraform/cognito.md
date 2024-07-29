Create a test user

aws cognito-idp admin-create-user --user-pool-id <your_user_pool_id> --username <your_user_id>
aws cognito-idp admin-set-user-password --user-pool-id <your_user_pool_id> --username <your_user_id> --password <your_password> --permanent



# Using CloudFormation Template with Terraform

As it is not possible to achieve this directly through Terraform, unlike the Matusko solution, I recommend using a CloudFormation template. 

## Why Use CloudFormation?

Using a CloudFormation template has several advantages:

- **No additional applications required**: It doesn't require additional applications to be installed locally.
- **Managed by Terraform**: The CloudFormation stack can be managed and destroyed by Terraform.

## Example CloudFormation Template

Below is a simple solution using a CloudFormation template. Note that I have skipped files and resources that are not directly related, such as providers. The example also includes joining users with groups.

### Step 1: Create a CloudFormation Template

Create a CloudFormation template file (e.g., `cloudformation-template.yaml`) with the following content:

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Resources:
  MyUser:
    Type: AWS::IAM::User
    Properties: 
      UserName: !Ref UserName

  MyGroup:
    Type: AWS::IAM::Group
    Properties:
      GroupName: !Ref GroupName

  MyUserToGroupAddition:
    Type: AWS::IAM::UserToGroupAddition
    Properties: 
      GroupName: !Ref GroupName
      Users: 
        - !Ref UserName
Parameters:
  UserName:
    Type: String
    Description: Name of the IAM user

  GroupName:
    Type: String
    Description: Name of the IAM group
Step 2: Integrate CloudFormation with Terraform
Create a Terraform file (e.g., main.tf) to manage the CloudFormation stack:

hcl
Copy code
provider "aws" {
  region = "us-west-2"
}

resource "aws_cloudformation_stack" "example" {
  name         = "example-stack"
  template_body = file("cloudformation-template.yaml")

  parameters = {
    UserName  = "example-user"
    GroupName = "example-group"
  }
}

output "stack_id" {
  value = aws_cloudformation_stack.example.id
}
Step 3: Apply the Terraform Configuration
Initialize Terraform and apply the configuration.




EDGE LAMBDA

Authorization@Edge using cookies: Protect your Amazon CloudFront content from being downloaded by unauthenticated users
by Otto Kruse | on 16 AUG 2019 | in Advanced (300), Amazon CloudFront, Amazon Cognito, Lambda@Edge, Networking & Content Delivery | Permalink |  Comments |  Share
Enterprise customers who host private web apps on Amazon CloudFront may struggle with a challenge: how to prevent unauthenticated users from downloading the web app’s source code (for example, React, Angular, or Vue). In a separate blog post, you can learn one way to provide that security using Amazon Lambda@Edge and Amazon Cognito, with an example implementation based on HTTP headers. To learn more about edge networking with AWS, click here.

In this article, we focus on the same use case, sharing an alternate solution that also uses Lambda@Edge and Cognito but is based on HTTP cookies. Using cookies provides transparent authentication to web apps, and also allows you to secure downloads of any content, not just source code.

Overview: Preventing unauthorized content download
Many web apps today are created as a Single Page Application (SPA). A SPA is a single HTML page—index.html—bundled together with JavaScript and CSS. JavaScript is at the core of every SPA, and there are several JavaScript frameworks and libraries to help developers create SPAs, including React, Angular, and Vue.

Companies can choose to host corporate internal SPAs publicly on Amazon CloudFront, using Amazon Simple Storage Service (S3) as the origin. By doing this, companies leverage the advantages of serverless hosting: low costs and no servers to manage. Hosting the app in the cloud also makes it easy for users to access it, especially on a mobile device where they might not be connected to the corporate network. To use the app, they just need internet access.

The downside of publicly hosting an internal SPA is that potential attackers can also download the SPA, not just the intended users. While attackers can’t sign in, they can analyze the source code to learn what the SPA does and which backend API endpoints it connects to. They might even spot a security bug that you’re unaware of.

One common mitigation to thwart analysis of how a SPA works is to obfuscate (“uglify”) the SPA’s source code. The SPA will still run and perform the same tasks but it’s very hard for humans to step through it. However, this is not foolproof security against determined attackers.

In this blog post, we explore another mitigation: Using Amazon Lambda@Edge to prevent unauthenticated users from even downloading the SPA’s source code. The earlier blog post explains one way to do this, using HTTP headers. With the HTTP headers solution, you must separate your SPA into public and private parts, you must set HTTP headers while downloading the private part, and you must have code that manages all of that. In our solution, we use cookies instead of headers, which makes the functionality transparent to your SPA. Lambda@Edge sets the cookies after sign-in and browsers automatically send the cookies on subsequent requests. That means that the only change you need to make to your SPA is to configure it so that it recognizes the cookies.

In fact, this solution can be used generically to add Cognito authentication to CloudFront web distributions. For example, you can secure CloudFront S3 bucket origins that have private content, such as images.

The building blocks of the sample solution
For the sample solution, we use the following main building blocks:

A private S3 bucket to host the SPA.
A CloudFront distribution to serve the SPA to users.
A Lambda@Edge function to inspect the JSON Web Tokens (JWTs) that are included in cookies in incoming requests. The function either allows a request or redirects it to authenticate, based on whether the user is already signed in.
A Lambda@Edge function that sets the correct cookies when a user signs in. The user’s browser automatically sends these cookies in subsequent requests, which makes the sign-in persistent across requests.
A Cognito user pool with a hosted UI setup that allows users to complete sign-in.
The solution uses the standard “Authorization code with PCKE” OAuth2 grant, which is supported by Cognito.

Deploying the sample solution
You can deploy this solution from the AWS Serverless Application Repository. The provided solution deploys with all of the building blocks integrated together, including a sample SPA, implemented in React (you can replace this with your own SPA).

The solution has a number of parameters that you can safely leave set to the default values. If you provide an email address, the solution creates a user in the user pool so that you can sign in and try out the example.

https://aws.amazon.com/blogs/networking-and-content-delivery/authorizationedge-using-cookies-protect-your-amazon-cloudfront-content-from-being-downloaded-by-unauthenticated-users/

https://github.com/GabrielAraujo/medium/blob/exploring_cognito_user_pools/ses.tf
https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples/complete/main.tf

https://medium.com/@jith/a-practical-introduction-to-aws-lambda-api-gateway-cognito-dynamo-db-s3-hosting-and-60002b22947a

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool

sample template
https://github.com/PouncingPoodle/aws-cognito-angularjs/blob/master/README.md


Cognito Labs

https://www.cognitobuilders.training/20-lab1/
https://www.npmjs.com/package/amazon-cognito-identity-js

SDK
https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/CognitoIdentityServiceProvider.html
https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/Welcome.html

code examples
https://docs.aws.amazon.com/cognito/latest/developerguide/service_code_examples_cognito-identity-provider.html

repo
https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/javascriptv3/example_code/cognito-identity-provider#code-examples


https://cognito-idp.eu-west-1.amazonaws.com/eu-west-1_zolXjjxxh/.well-known/openid-configuration