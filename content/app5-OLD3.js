
  
// var hash = CryptoJS.HmacSHA256("message", "secret");
// var hashInBase64 = CryptoJS.enc.Base64.stringify(hash);
// document.getElementById('output').innerHTML = hashInBase64;
// const crypto = require('crypto-js');
// const hasher = crypto.createHmac('sha256', poolData.ClientSecret);
// const crypto = crypto
// const hasher = crypto.createHmacHelper('sha256', poolData.ClientSecret);
//   // AWS wants `"Username" + "Client Id"`
//   hasher.update(`${username}${poolData.ClientId}`);
//   const secretHash = hasher.digest('base64');

// var CryptoJS = require("crypto-js");
// import { createHmac } from "crypto" 
// if (typeof CryptoJS === 'undefined' && typeof require === 'function') {
//     // var crypto = require('crypto-js');
//     var SHA256 = require("crypto-js/sha256");
//   }
//   console.log(SHA256);
if (typeof CryptoJS === 'undefined' && typeof require === 'function') {
    var CryptoJS = require('crypto-js');
    var Base64 = require('crypto-js/enc-base64');
  }
console.log(CryptoJS);
// const​ hash = CryptoJS.HmacSHA256('message', 'secret');
// console.log('hash:' + hash);
// const username = "tonychue@gmail.com"

// import CryptoJS from 'crypto-js';
// import Base64 from 'crypto-js/enc-base64';


// Generate the hash using HMAC-SHA256 and encode to Base64
// var hash = CryptoJS.HmacSHA256(data, secretKey).toString(CryptoJS.enc.Base64);
// console.log('hash:' + hash);

AWS.config.region = 'us-east-1';
AWS.config.credentials = new AWS.CognitoIdentityCredentials({
    IdentityPoolId: poolData.IdentityPoolId,
});

const signUp = async () => {
    var cognitoidentityserviceprovider = new AWS.CognitoIdentityServiceProvider();
    const username = document.getElementById('sign-up-email').value;
    const password = document.getElementById('sign-up-password').value;
    const personalname = document.getElementById('personalname-register').value;
    // var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

    var secretKey = poolData.ClientSecret;
    var data = `${username}${poolData.ClientId}`;
// Generate the hash using HMAC-SHA256 and encode to Base64
    var secretHash = CryptoJS.HmacSHA256(data, secretKey).toString(CryptoJS.enc.Base64);
    console.log('hash:' + secretHash);

        var params = {
            ClientId: poolData.ClientId, 	/* required */
            Password: password, /* required */
            Username: username, /* required */
            // SecretHash: hashSecret(poolData.ClientSecret, username, poolData.ClientId),
            SecretHash:secretHash,
            ValidationData: [],						/* required */
            UserAttributes: attributeList
        };
        // var params = {
        //     AuthFlow: "USER_PASSWORD_AUTH", 
        //     AuthParameters: {
        //      "PASSWORD": password, 
        //      "SECRET_HASH": poolData.ClientSecret, 
        //      "USERNAME": username,
        //     }, 
        //     ClientId: poolData.ClientId, 	/* required */
        // };
        if (document.getElementById('sign-up-password').value != document.getElementById('confirm-password').value) 
        { 
            alert('Password do not match!')
            throw "Password do not match!"
        }
        else{
            const password = document.getElementById('sign-up-password').value;
        }
        var attributeList = [];

        var dataEmail = {
            Name: 'email',
            Value: username,
        };
        
        var dataPersonalName = {
            Name: 'name',
            Value: personalname,
        };
        var attributeEmail = new AmazonCognitoIdentity.CognitoUserAttribute(dataEmail);
        var attributePersonalName = new AmazonCognitoIdentity.CognitoUserAttribute(
            dataPersonalName
        );
        
        attributeList.push(attributeEmail);
        attributeList.push(attributePersonalName);
        cognitoidentityserviceprovider.signUp(params, function(err, data) {
            if (err) {
                console.log(err, err.stack); // an error occurred
                alert('Error: '+ JSON.stringify(err));
                return;
            }
            else {
                console.log(JSON.stringify(data));           // successful response
                location.href = "./confirm.html#" + username;
            }
        });
        
    // cognitoidentityserviceprovider.signUp(params, function(err, data){
    //         if (err) console.log(err, err.stack); // an error occurred
    //         else     console.log(data);           // successful response
    //     });
        
        
        // await userPool.signUp(
        //     username,
        //     password,
        //     attributeList,
        //     null,
        //     function (err, result) {
        //         if (err) {
        //             alert(err.message || JSON.stringify(err));
        //             return;
        //         }
        //         else{
        //         // var cognitoUser = result.user;
        //         // console.log('user name is ' + cognitoUser.getUsername());
        //         // document.getElementById("titleheader").innerHTML ="Check your email for verification";
        //             location.href = "./confirm.html#" + username;
        //         }
        //     }
        // );
};

function hashSecret(clientSecret, username, clientId) {
    console.log(SHA256('my message'));
  }
const confirmCode = async () => {
    // const code = document.getElementById('confirm').value;
    const code = document.querySelector("#confirm").value;
    const username = location.hash.substring(1);
    var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
    var userData = {
        Username: username,
        Pool: userPool,
    };
    
    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.confirmRegistration(code, true, function (err, result) {
        if (err) {
            alert(err.message || JSON.stringify(err));
            return;
        }
        else {
            console.log("confirmed");
            console.log('call result: ' + result);
            location.href = "./index.html";
          }
        
    });
}


const resendCode = async () => {
    const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
    const username = location.hash.substring(1);
    const cognitoUser = new AmazonCognitoIdentity.CognitoUser({
      Username: username,
      Pool: userPool,
    });
    cognitoUser.resendConfirmationCode(function (err) {
      if (err) {
        alert(err);
      }
    });
  };





//   let result = await cognitoIdentityServiceProvidor
//   .initiateAuth({
//     AuthFlow: "REFRESH_TOKEN",
//     ClientId: clientId,
//     AuthParameters: {
//       REFRESH_TOKEN: refresh_token,
//       SECRET_HASH: clientSecret,
//     },
//   })
//   .promise();