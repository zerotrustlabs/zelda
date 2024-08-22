
const signUp = () => {
    // event.preventDefault();
    // console.log("signup");
    // var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
    // const username = document.querySelector("#username").value;
    // const emailadd = document.querySelector("#email").value;
    // const password = document.querySelector("#password").value;
  
    // var email = new AmazonCognitoIdentity.CognitoUserAttribute({
    //   Name: "email",
    //   Value: emailadd,
    // });
  
    // userPool.signUp(username, password, [email], null, function (err, result) {
    //   if (err) {
    //     alert(err);
    //   } else {
    //     location.href = "confirm.html#" + username;
    //   }
    // });

    // var CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
    var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
    // console.log(userPool);
// ES Modules, e.g. transpiling with Babel

    var attributeList = [];

    var dataEmail = {
        Name: 'email',
        Value: 'email@mydomain.com',
    };

    var dataPhoneNumber = {
        Name: 'phone_number',
        Value: '+15555555555',
    };
    var attributeEmail = new AmazonCognitoIdentity.CognitoUserAttribute(dataEmail);
    var attributePhoneNumber = new AmazonCognitoIdentity.CognitoUserAttribute(
        dataPhoneNumber
    );

    attributeList.push(attributeEmail);
    attributeList.push(attributePhoneNumber);

    // userPool.signUp(
    //     'username',
    //     'password',
    //     attributeList,
    //     null,
    //     function (err, result) {
    //         if (err) {
    //             alert(err.message || JSON.stringify(err));
    //             return;
    //         }
    //         var cognitoUser = result.user;
    //         // console.log('user name is ' + cognitoUser.getUsername());
    //     }
    // );
  };





//   
// var poolData = {
// 	UserPoolId: '...', // Your user pool id here
// 	ClientId: '...', // Your client id here
// };
// var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

// var attributeList = [];

// var dataEmail = {
// 	Name: 'email',
// 	Value: 'email@mydomain.com',
// };

// var dataPhoneNumber = {
// 	Name: 'phone_number',
// 	Value: '+15555555555',
// };
// var attributeEmail = new AmazonCognitoIdentity.CognitoUserAttribute(dataEmail);
// var attributePhoneNumber = new AmazonCognitoIdentity.CognitoUserAttribute(
// 	dataPhoneNumber
// );

// attributeList.push(attributeEmail);
// attributeList.push(attributePhoneNumber);

// userPool.signUp(
// 	'username',
// 	'password',
// 	attributeList,
// 	null,
// 	function (err, result) {
// 		if (err) {
// 			alert(err.message || JSON.stringify(err));
// 			return;
// 		}
// 		var cognitoUser = result.user;
// 		console.log('user name is ' + cognitoUser.getUsername());
// 	}
// );