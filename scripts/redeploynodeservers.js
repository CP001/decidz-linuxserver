//Require module
var sys = require('sys');
var execSync = require('exec-sync');
var dateFormat = require('dateformat');
var sleep = require('sleep');
var Guid = require('guid');

var CONFIG_FILE_LOCATION = "/var/www/decidz/scripts/config/deploymentconfig.json";
var HELPERS_SCRIPTS_FOLDER_LOCATION = "/var/www/decidz/scripts/helpers/";
var LOG_FILE_LOCATION = "/var/www/decidz/websites/manage.decidz.com/prod/deploymentlogs/";
var WEBSITE_LOGS_LOCATION="http://manage.decidz.com/deploymentlogs/";
var DEVMODE = false;

function loadconfig() {
	var fs = require('fs');
	try {
		var jsondata = JSON.parse(fs.readFileSync(CONFIG_FILE_LOCATION, 'utf8'));
		return jsondata;
	} catch (err) {
		// error in json config file format
		console.log(err);
		messageslackchannel("ERROR - config file issue - /var/www/decidz/scripts/config/deploymentconfig.json");
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

function redeployallnodesites(envname){
	var jsondata = loadconfig();

	console.log("Redeploying node servers for " + envname);
	logstuff("Redeploying node servers for " + envname);
	// iterate through the deployments
	if (jsondata != "") {
		for(var key in jsondata){
			if(jsondata.hasOwnProperty(key)) {
				// check if this is relevant to the environment being specified
				if (key.toLowerCase().indexOf(envname) > -1) {
					// check if this is a node script of some form
					if ((jsondata[key].type == "nodescript") || (jsondata[key].type == "nodewebsite")) {
						console.log("creating deployment flag file for " + key);
					}
				}
			}
		}		
	}
	logstuff("Flag files created - deployments will be picked up shortly!");
//	messageslackchannel("Node servers started after decidz-1 server reboot - <" + WEBSITE_LOGS_LOCATION + glogfilename + "|view log file>");
}

function logstuff(logmessage) {
	var fs = require('fs');
	var timenow = new Date();
	// check if file exists and then either create or append to the file
	if (fileexists(LOG_FILE_LOCATION + glogfilename)) {
		fs.appendFileSync(LOG_FILE_LOCATION + glogfilename, "<b>" + dateFormat(timenow, "yyyy-dd-mm hh:MM:ss: ") + "</b> " + logmessage + "</br>\r\n");
	} else {
		fs.writeFileSync(LOG_FILE_LOCATION + glogfilename, "<html><body><b>" + dateFormat(timenow, "yyyy-dd-mm hh:MM:ss: ") + "</b> " + logmessage + "</br>\r\n");
	}
}

function logstextarea(logmessage, numrows) {
	var fs = require('fs');
	var timenow = new Date();
	fs.appendFileSync(LOG_FILE_LOCATION + glogfilename, "<textarea rows='" + numrows + "' cols='160'>" + logmessage + "</textarea></br></br>\r\n");
}

function messageslackchannel(slackmessage) {
	if (DEVMODE) {
		output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'sendslackmessage.sh "@craig" "' + slackmessage + '"');		
	} else {
		output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'sendslackmessage.sh "#deployment" "' + slackmessage + '"');
	}
}

var now = new Date();
var glogfilename = dateFormat(now, "yyyymmdd-HHMMss-") + Guid.raw() + ".html";
var envname = process.argv[2];

if (envname != "") {
	// redeploy all node sites in this environment
	redeployallnodesites('_' + envname);
} else {
	console.log("Environment needed - prod, staging or int");
}