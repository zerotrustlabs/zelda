
Elevate API Security with Cognito and WAF
https://github.com/aws-samples/elevate-api-security-with-cognito-and-waf?tab=readme-ov-file

https://github.com/aws-samples/elevate-api-security-with-cognito-and-waf/blob/main/content/300_Multilayered_API_Security_with_Cognito_and_WAF/1_deploy_the_lab_base_infrastructure.md

This lab is provided as part of AWS Innovate - Modern Applications

ℹ️ You will run this lab in your own AWS account. Please follow directions at the end of the lab to remove resources to avoid future costs.

Introduction
APIs are used for integration between applications and assist our customers in delivering new digital businesses as public APIs in partner ecosystems. Due to the public nature of these APIs, security is a top concern for all organizations who seek to develop APIs to augment their existing business models. Although API security now benefits from increased awareness and product feature coverage, application leaders must create and implement an effective API security strategy which aligns with their business needs. An example of an effective approach to secure an API is to adopt a Zero Trust strategy which ensures only authorized requests are permitted to access the business layer of your application. Additionally, evaluating trust at multiple layers of the architecture allows multiple checks to be performed as the API data transits through the workload.

Through the use of AWS Cognito, it is possible to create user pools which work with your API to obtain an identity access token for the user, which can then be used to enforce authorization controls in your API layer. However, not only can legitimate users potentially expose your organization to high risk, but also attacks can come with valid credential or token. To mitigate this risk, AWS Cognito enables you to configure how long your access token will be valid and the integration of Amazon WAF in conjunction with CloudFront will allow you to add another layer of API security to achieve a strong level of protection.

In this lab we will walk you through an example scenario of securing your API at multiple layers. We will gradually tighten the security at each layer, using the following services:

Amazon API Gateway - Used for securing REST API.
AWS Secrets Manager - Used to securely store secrets.
Amazon CloudFront - Used to prevent direct access to API as well as to enforce encrypted end-to-end connections to origin.
AWS WAF - Used to protect our API by filtering, monitoring, and blocking malicious traffic.
Amazon Cognito - Used to enable access control for API