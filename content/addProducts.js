const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();
exports.handler = async (event) => {
    const requestJSON = JSON.parse(event.body);
    // product.productId = '9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d';

    const params = {
        TableName: "Products",
        Item: {
            id: requestJSON.id,
            price: requestJSON.price,
            name: requestJSON.name,
          },
    };

    try {
        await dynamo.put(params).promise();
        return {
            statusCode: 200,
            body: JSON.stringify({ message: "Product added" })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: "Could not add product" })
        };
    }
};
