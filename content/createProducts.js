import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { QueryCommand, DynamoDBDocumentClient } from "@aws-sdk/lib-dynamodb";
// const AWS = require('aws-sdk');
// const dynamoDb = new AWS.DynamoDB.DocumentClient();

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
    const data = JSON.parse(event.body);
    const params = {
        TableName: 'ProductCatalog',
        Item: {
            ProductId: data.productId,
            name: data.name,
            price: data.price,
            description: data.description,
        },
    };

    try {
        await  docClient.put(params).promise();
        return {
            statusCode: 201,
            body: JSON.stringify({ message: 'Product created successfully' }),
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: 'Could not create product' }),
        };
    }
};



// const client = new DynamoDBClient({});
// const docClient = DynamoDBDocumentClient.from(client);

// export const handler = async (event) => {
//   //var data = await DynamoDBClient.scan({ TableName: "dcn" }).promise();
//   const command = new QueryCommand({
//     TableName: "dcn",
//     KeyConditionExpression:"id = :id",
//     ExpressionAttributeValues: {":id":"xyz"},
//     ConsistentRead: true,
//   });
//   const dbResp = await docClient.send(command);
//   const response = {
//     statusCode: 200,
//     body: JSON.stringify(dbResp),
//   };
//   return response;
// };
