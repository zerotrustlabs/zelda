const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    const product = JSON.parse(event.body);

    const params = {
        TableName: "Products",
        Key: {
            "productId": product.productId
        },
        UpdateExpression: "set #name = :name, price = :price, category = :category",
        ExpressionAttributeNames: {
            "#name": "name"
        },
        ExpressionAttributeValues: {
            ":name": product.name,
            ":price": product.price,
            ":category": product.category
        }
    };

    try {
        await dynamo.update(params).promise();
        return {
            statusCode: 200,
            body: JSON.stringify({ message: "Product updated" })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: "Could not update product" })
        };
    }
};
