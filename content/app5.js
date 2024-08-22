
const signUp = async () => {
    const username = document.getElementById('sign-up-email').value;
    const password = document.getElementById('sign-up-password').value;
    const personalname = document.getElementById('personalname-register').value;
    var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
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

    await userPool.signUp(
        username,
        password,
        attributeList,
        null,
        function (err, result) {
            if (err) {
                alert(err.message || JSON.stringify(err));
                return;
            }
            else{
            // var cognitoUser = result.user;
            // console.log('user name is ' + cognitoUser.getUsername());
            // document.getElementById("titleheader").innerHTML ="Check your email for verification";
                location.href = "./confirm.html#" + username;
            }
        }
    );
};

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
