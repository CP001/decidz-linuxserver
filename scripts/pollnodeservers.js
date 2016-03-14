//Require module
var sys = require('sys');
var execSync = require('exec-sync');
var CONFIG_FILE_LOCATION = "/var/www/decidz/scripts/config/deploymentconfig.json";
var HELPERS_SCRIPTS_FOLDER_LOCATION = "/var/www/decidz/scripts/helpers/";

function loadconfig() {
	var fs = require('fs');
	try {
		var jsondata = JSON.parse(fs.readFileSync(CONFIG_FILE_LOCATION, 'utf8'));
		return jsondata;
	} catch (err) {
		// error in json config file format
		console.log(err);
		return "";
	}
}

function fileexists(filename) {
	var fs = require('fs');
	try {
		// Query the entry
		stats = fs.lstatSync(filename);
		return true;
	}
	catch (e) {
		return false;
	}
}

function checkallnodesites(){
	var jsondata = loadconfig();

	console.log("Checking node servers");
	// iterate through the deployments
	if (jsondata != "") {
		for(var key in jsondata){
			if(jsondata.hasOwnProperty(key)) {
				checknodesite(key);
			}
		}		
	}
//	messageslackchannel("Node servers started after decidz-1 server reboot - <" + WEBSITE_LOGS_LOCATION + glogfilename + "|view log file>");
}

function checknodesite(sitename) {
	var fs = require('fs');
	var jsondata = loadconfig();
	if (jsondata != "") {
		startnodeserver = jsondata[sitename].start_node_server_at_reboot;
		itemenabled = jsondata[sitename].enabled;
		if ((itemenabled == "") || !(itemenabled)) {
			itemenabled = "yes";
		}
		if ((startnodeserver == "yes") && (itemenabled == "yes")) {
			// need to check status of this node script
			// if its staging need to check pm2 process directly
//			if ((sitename.toLowerCase().indexOf("_staging") > -1) || (sitename.toLowerCase().indexOf("_int") > -1)) {
				console.log("Checking node script " + sitename);
				output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'checkpm2nodescript.sh ' + sitename);
//			} else {
//				nodewebsiteroot = jsondata[sitename].node_website_root;
//				console.log("Checking node script " + sitename + "_worker.js");
//				output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'checknodescript.sh ' + nodewebsiteroot + ' ' + sitename + '_worker.js' + ' ' + sitename);				
//			}
		}
	}		
}

function messageslackchannel(slackmessage) {
	if (DEVMODE) {
		output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'sendslackmessage.sh "@craig" "' + slackmessage + '"');		
	} else {
		output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'sendslackmessage.sh "#deployment" "' + slackmessage + '"');
	}
}

// start node sites
checkallnodesites();		
