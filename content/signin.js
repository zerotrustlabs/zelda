// import * as AWS from 'aws-sdk/global';
const signIn = async () => {
    const username = document.getElementById('sign-in-email').value;
    const password = document.getElementById('sign-in-password').value;
    var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
    var authenticationData = {
        Username: username,
        Password: password,
    };
    var authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData)
    var userData = {
        Username: username,
        Pool: userPool,
    };

    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (result) {
            alert('successfully logged in');
            var accessToken = result.getAccessToken().getJwtToken();

            //POTENTIAL: Region needs to be set if not already set previously elsewhere.
            AWS.config.region = 'us-east-1';

            AWS.config.credentials = new AWS.CognitoIdentityCredentials({
                IdentityPoolId: 'us-east-1:7525cb05-110b-447a-a225-9732179064c1', // your identity pool id here
                Logins: {
                    // Change the key below according to the specific region your user pool is in.
                    'cognito-idp.us-east-1.amazonaws.com/us-east-1_Du0DwagbQ': result
                        .getIdToken()
                        .getJwtToken(),
                },
            });

            // //refreshes credentials using AWS.CognitoIdentity.getCredentialsForIdentity()
            AWS.config.credentials.refresh(error => {
                if (error) {
                    alert(error);
                } else {
                    // Instantiate aws sdk service objects now that the credentials have been updated.
                    // example: var s3 = new AWS.S3();
                    alert('Successfully refreshed logged in!');
                }
            });
        },

        onFailure: function (err) {
            alert(err.message || JSON.stringify(err));
        },
    });
}


