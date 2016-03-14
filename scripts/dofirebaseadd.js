var Firebase = require("firebase");
var FIREBASEURL = "https://decidzmanage.firebaseio.com";
var FIREBASEAUTHCODE = "Fs0Q6sSOZKgth3aFj9HAus826Tmb9onxrJUOreeS";

function addfirebaserecord(firebasekey, firebasedata){
	var ref = new Firebase(FIREBASEURL + firebasekey);
	ref.authWithCustomToken(FIREBASEAUTHCODE, function(error, errordata) {});	
    ref.put(firebasedata, function(error, errordata) {
		process.exit(0);
	});
}

var option1 = process.argv[2];
var option2 = process.argv[3];

if ((option1 != "") && (option2 != "")) {
	addfirebaserecord(option1, option2);
}