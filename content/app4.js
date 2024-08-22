var poolData = {
	UserPoolId: '...', // Your user pool id here
	ClientId: '...', // Your client id here
};
var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

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

userPool.signUp(
	'username',
	'password',
	attributeList,
	null,
	function (err, result) {
		if (err) {
			alert(err.message || JSON.stringify(err));
			return;
		}
		var cognitoUser = result.user;
		console.log('user name is ' + cognitoUser.getUsername());
	}
);