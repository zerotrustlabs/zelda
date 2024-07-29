There was a problem using serverside encryption with S3 Static website
 Error Message:
 Message: The object was stored using a form of Server Side Encryption. The correct parameters must be provided to retrieve the object.


Static Website hosting on Encrypted S3
This is going to be a loaded question...

I am trying to host a website on an encrypted S3 bucket that uses an API & Lambda to pull images (.jpg / .png) and display them on the webpage.

The solution is to revert to the default SSE encryption
and figured to just use default encryption by AES-256 than KMS.

There are two different buckets:

The website and its files

The images that can be pulled

Both are encrypted using KMS. I need a way to unencrypt the webpage so it can be visible to internal people, and a way to decrypt the chosen images (picked from a json populated dropdown box).

Has anyone done anything similar to this?

Errors I am getting:

Accessing the HTML file in the bucket: Requests specifying Server Side Encryption with AWS KMS managed keys require AWS Signature Version 4.

Clicking the link in static Hosting:

400 Bad Request

Code: InvalidRequest

Message: The object was stored using a form of Server Side Encryption. The correct parameters must be provided to retrieve the object.

I hit the same problem as yours, and figured to just use default encryption by AES-256 than KMS.

Objects in the bucket can't be AWS KMS-encrypted
AWS KMS doesn't support anonymous requests. As a result, any Amazon S3 bucket that allows anonymous or public access will not apply to objects that are encrypted with AWS KMS. You must remove KMS encryption from the objects that you want to serve using the Amazon S3 static website endpoint.

Note: Instead of using AWS KMS encryption, use AES-256 to encrypt your objects.
https://repost.aws/knowledge-center/s3-static-website-endpoint-error

https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingServerSideEncryption.html
If you require your data uploads to be encrypted using only Amazon S3 managed keys, you can use the following bucket policy. For example, the following bucket policy denies permissions to upload an object unless the request includes the x-amz-server-side-encryption header to request server-side encryption:
{
  "Version": "2012-10-17",
  "Id": "PutObjectPolicy",
  "Statement": [
    {
      "Sid": "DenyObjectsThatAreNotSSES3",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::DOC-EXAMPLE-BUCKET/*",
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "AES256"
        }
      }
    }
   ]
}


===
AWS CloudFront redirecting to S3 bucket
https://stackoverflow.com/questions/38735306/aws-cloudfront-redirecting-to-s3-bucket
Use the regional domain name of your S3 bucket to configure the CloudFront distribution's origin, e.g.: {bucket-name}.s3.{region}.amazonaws.com.

Explanation
According to the discussion on AWS Developer Forums: Cloudfront domain redirects to S3 Origin URL (via archive.org), it takes time for DNS records to be created and propagated for newly created S3 buckets. The issue is not visible for buckets created in US East (N. Virginia) region, because this region is the default one (fallback).

Each S3 bucket has two domain names, one global and one regional, i.e:

global — {bucket-name}.s3.amazonaws.com
regional — {bucket-name}.s3.{region}.amazonaws.com
If you configure your CloudFront distribution to use the global domain name, you will probably encounter this issue, due to the fact that DNS configuration takes time.

However, you could use the regional domain name in your origin configuration to escape this DNS issue in the first place.

Cognito Issues
https://repost.aws/questions/QUWQXaGAzPTXy95oH8DupLJg/aws-sdk-for-javascript-v3-is-amazon-cognito-identity-js-becoming-deprecated-or-has-security-issues-in-favor-of-aws-amplify-v6