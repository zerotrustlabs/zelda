Post authentication Lambda

Test invoke using the following
{
  "triggerSource": "testTrigger",
  "userPoolId": "testPool",
  "userName": "testName",
  "callerContext": {
      "clientId": "12345"
  },
  "response": {}
}

Create Cloudwatch log Anomaly Detection
CloudWatch Logs Anomaly Detection is available at no additional cost for all standard class logs.
Activate anomaly detection policy to begin continuous pattern recognition and anomaly detection for this log group. Training completes in 5 minutes in most cases. For some large log groups, it can take up to 2 hours.

[83078518-fcc1-4d30-9573-8b9737671438] BENCHMARK : Running Start Crawl for Crawler TestCrawler2
[83078518-fcc1-4d30-9573-8b9737671438] BENCHMARK : Classification complete, writing results to database mygluedatabase
[83078518-fcc1-4d30-9573-8b9737671438] INFO : Crawler configured with SchemaChangePolicy 



LAMBDA EDGE

Lambda executes functions based on certain triggers. The use case for Lambda is quite broad and there is heavy integration with many AWS Services. You can even use it to simply execute the code via AWS's API and receive the code into your scripts separate from AWS. Common use cases include Lambdas being simply executed and the output received, plugged into API Gateway to serve user requests, modifying objects as they are placed into S3 buckets, etc.

Lambda@Edge is a service that allows you to execute Lambda functions that modify the behaviour of CloudFront specifically. Lambda@Edge simply runs during the request cycle and makes logical decisions that affect the delivery of the CloudFront content.

https://aws.amazon.com/lambda/features/

https://docs.aws.amazon.com/lambda/latest/dg/lambda-edge.html

Edge Lambda condition
has to be created in us-east-1 region
if code taken from bucket, bucket also needs to be in us-east-1 region
you can't pass environment variables the same way as to normal lambda fn. Either you need to hardcode values during build process or hardcode env and fetch values from somewhere else.
Lambda Edge Examples
https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-examples.html