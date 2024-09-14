# lambda_function.py

import json
import boto3

def lambda_handler(event, context):
    sagemaker = boto3.client('sagemaker')
    
    response = sagemaker.create_processing_job(
        ProcessingJobName='AnomalyDetectionProcessingJob',
        ProcessingInputs=[
            {
                'InputName': 'input-1',
                'S3Input': {
                    'S3Uri': 's3://my-log-bucket/logs/',
                    'LocalPath': '/opt/ml/processing/input',
                    'S3DataType': 'S3Prefix',
                    'S3InputMode': 'File'
                }
            }
        ],
        ProcessingOutputConfig={
            'Outputs': [
                {
                    'OutputName': 'output-1',
                    'S3Output': {
                        'S3Uri': 's3://my-log-bucket/output/',
                        'LocalPath': '/opt/ml/processing/output',
                        'S3UploadMode': 'EndOfJob'
                    }
                }
            ]
        },
        ProcessingResources={
            'ClusterConfig': {
                'InstanceCount': 1,
                'InstanceType': 'ml.m5.large',
                'VolumeSizeInGB': 30
            }
        },
        StoppingCondition={
            'MaxRuntimeInSeconds': 3600
        },
        RoleArn='arn:aws:iam::123456789012:role/lambda-execution-role'
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Processing job started')
    }
