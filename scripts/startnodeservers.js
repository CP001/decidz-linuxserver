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

function startallnodesites(){
	var jsondata = loadconfig();

	console.log("Starting node servers after reboot");
	logstuff("Starting script /var/www/decidz/scripts/startnodeservers.js");
	// sleep for a few secs
	sleep.sleep(3);
	// iterate through the deployments
	if (jsondata != "") {
		for(var key in jsondata){
			if(jsondata.hasOwnProperty(key)) {
				if ((key.toLowerCase().indexOf("_staging") > -1) || (key.toLowerCase().indexOf("_int") > -1)) {
					startpm2nodesite(key);
				} else {
					startnodesite(key);
				}
			}
		}		
	}
	logstuff("Node servers started - script complete");
	messageslackchannel("Node servers started after decidz-1 server reboot - <" + WEBSITE_LOGS_LOCATION + glogfilename + "|view log file>");
}


function startpm2nodesite(sitename) {
	var fs = require('fs');
	var jsondata = loadconfig();
	if (jsondata != "") {
		startnodeserver = jsondata[sitename].start_node_server_at_reboot;
		itemenabled = jsondata[sitename].enabled;
		if ((itemenabled == "") || !(itemenabled)) {
			itemenabled = "yes";
		}
		if ((startnodeserver == "yes") && (itemenabled == "yes")) {
			nodewebsiteroot = jsondata[sitename].node_website_root;
			console.log("Starting node script " + sitename + "_worker.js");
			logstuff("Starting node script " + sitename + "_worker.js");
			output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'startpm2nodescript.sh ' + nodewebsiteroot + '/' + sitename + '_worker.js ' + sitename + ' ' + nodewebsiteroot);
			logstextarea(output, 4);
		}
	}		
}


function startnodesite(sitename) {
	var fs = require('fs');
	var jsondata = loadconfig();
	if (jsondata != "") {
		startnodeserver = jsondata[sitename].start_node_server_at_reboot;
		itemenabled = jsondata[sitename].enabled;
		if ((itemenabled == "") || !(itemenabled)) {
			itemenabled = "yes";
		}
		if ((startnodeserver == "yes") && (itemenabled == "yes")) {
			nodewebsiteroot = jsondata[sitename].node_website_root;
			console.log("Starting node script " + sitename + "_worker.js");
			logstuff("Starting node script " + sitename + "_worker.js");
			output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'startnodescript.sh ' + nodewebsiteroot + ' ' + sitename + '_worker.js');
			logstextarea(output, 4);
		}
	}		
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
// start node sites
startallnodesites();		
