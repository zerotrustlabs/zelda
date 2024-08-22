const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    const { productId } = JSON.parse(event.body);

    const params = {
        TableName: "Products",
        Key: {
            "productId": productId
        }
    };

    try {
        await dynamo.delete(params).promise();
        return {
            statusCode: 200,
            body: JSON.stringify({ message: "Product deleted" })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: "Could not delete product" })
        };
    }
};
