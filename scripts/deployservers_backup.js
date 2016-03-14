//Require module
var sys = require('sys');
// var exec = require('child_process').exec;
// var execSync = require('child_process').execSync;
// var execFileSync = require('child_process').execFileSync
var sh = require('shelljs');
var execSync = require('exec-sync');
var Slack = require('slack-node');
var slackBot = require('slack-bot')('https://hooks.slack.com/services/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');
var dateFormat = require('dateformat');
var Guid = require('guid');
var sleep = require('sleep');
var Firebase = require("firebase");

var NGINX_SITES_AVAILABLE = "/etc/nginx/sites-available/";
var NGINX_SITES_ENABLED = "/etc/nginx/sites-enabled/";
var NGINX_TEMPLATE_FILE = "/var/www/decidz/scripts/config/templates/nginx_node_template.conf";
var CONFIG_FILE_LOCATION = "/var/www/decidz/scripts/config/deploymentconfig.json";
var LOG_FILE_LOCATION = "/var/www/decidz/websites/manage.decidz.com/prod/deploymentlogs/";
var TEMPLATES_FOLDER_LOCATION = "/var/www/decidz/scripts/config/templates/";
var HELPERS_SCRIPTS_FOLDER_LOCATION = "/var/www/decidz/scripts/helpers/";
var FLAGFILE_FOLDER="/var/www/decidz/flagfiles/";
var WEBSITE_LOGS_LOCATION="http://manage.decidz.com/deploymentlogs/";
var FIREBASEURL = "https://decidzmanage.firebaseio.com";
var FIREBASEAUTHCODE = "Fs0Q6sSOZKgth3aFj9HAus826Tmb9onxrJUOreeS";

function loadconfig() {
	var fs = require('fs');
	try {
		var jsondata = JSON.parse(fs.readFileSync(CONFIG_FILE_LOCATION, 'utf8'));
		return jsondata;
	} catch (err) {
		// error in json config file format
		console.log(err);
		messageslackchannel("#build-and-issues", "ERROR - config file issue - /var/www/decidz/scripts/config/deploymentconfig.json");
		return "";
	}
}

function installallsites() {
	var jsondata = loadconfig();

	// iterate through the configurations
	if (jsondata != "") {
		for(var key in jsondata){
			if(jsondata.hasOwnProperty(key)) {
				installsite(key);
			}
		}		
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


function movefile(oldfilename, newfilename) {
	var fs = require('fs');
	fs.renameSync(oldfilename, newfilename, function(err) {
		if ( err ) console.log('ERROR: ' + err);
	});
}

function deletefile(filename) {
	var fs = require('fs');
	fs.unlinkSync(filename, function(err) {
		if ( err ) console.log('ERROR: ' + err);
	});
}

function deployallsites(){
	var jsondata = loadconfig();

	// iterate through the configurations
	if (jsondata != "") {
		for(var key in jsondata){
			if(jsondata.hasOwnProperty(key)) {
				deploynodesite(key);
			}
		}		
	}

}

function checkfordeploymentflagfiles(){
	var jsondata = loadconfig();

	// iterate through the configurations
	if (jsondata != "") {
		for(var key in jsondata){
			if(jsondata.hasOwnProperty(key)) {
				// check for flag file now
				if (fileexists(FLAGFILE_FOLDER + "deploy_" + key + ".flag")) {
					console.log("Request to deploy " + key + " site");
					logstuff(FLAGFILE_FOLDER + "deploy_" + key + ".flag detected")
					// move the flag file to in progress
					logstuff("renaming file to " + FLAGFILE_FOLDER + "deploy_" + key + ".processing");
					movefile(FLAGFILE_FOLDER + "deploy_" + key + ".flag", FLAGFILE_FOLDER + "deploy_" + key + ".processing");
					try {
						servertype = jsondata[key].type;
					}
					catch (e) {
						servertype = "";
					}
					try {
						description = jsondata[key].description;
					}
					catch (e) {
						description = "";
					}
					// see if its a supported build type
					if (servertype == "nodewebsite") {
						// deploy node website
						console.log("Deploying node website " + description);
						deploynodesite(key);
					} else if (servertype == "nodescript") {
						// deploy simple node script - handled by deploynodesite function
						console.log("Deploying node script " + description);
						deploynodesite(key);
					} else {
						// curently unsupported build mechanism
						console.log("Deploying website - " + description);
						logstuff("Deploying website - " + description);
						deploymainwebsite(key, description);
					}
					deletefile(FLAGFILE_FOLDER + "deploy_" + key + ".processing");
				}
			}
		}		
	}

}

function deploymainwebsite(sitename, description) {
	var fs = require('fs');
	console.log("Loading details for site " + description);
	logstuff("Loading details for site " + description);
	messageslackchannel("#build-and-issues", "Deployment to " + description + " started - " + WEBSITE_LOGS_LOCATION + glogfilename);
	
	// work out environment for deploying to, etc
	var site_environment = sitename.substr(7);
	if (site_environment == "prod") {
		site_environment = "prefirebase";
		site_environment2 = "prod";
	} else {
		site_environment2 = site_environment;
	}
	logstuff("Creating firebase deployment record for " + site_environment2);
	addfirebaserecord("/deploymenthistory/" + site_environment2, {"key" : sitename, "logfile" : glogfilename});
	
	var jsondata = loadconfig();
	if (jsondata != "") {
		// see if the sitename exists in the json file
		try {
			description = jsondata[sitename].description;
		}
		catch (e) {
			description = "";
		}
		if((description != "") && (description)){
			console.log("Deploying " + description);
			logstuff("Deploying " + description);
			deployment_branch = "";
			deployment_email = "";
			
			try {
				var jsondeploymentdata = JSON.parse(fs.readFileSync(FLAGFILE_FOLDER + "deploy_" + sitename + ".processing", 'utf8'));
				deployment_branch = jsondeploymentdata.branch;
				deployment_email = jsondeploymentdata.useremail;
				deployment_codename = jsondeploymentdata.codename;
				deployment_majorreleaseversion = jsondeploymentdata.majorreleaseversion;
				deployment_minorreleaseversion = jsondeploymentdata.minorreleaseversion;
				deployment_patchreleaseversion = jsondeploymentdata.patchreleaseversion;
				deployment_deploytofirebase = jsondeploymentdata.deploytofirebase;
			} catch (err) {
				console.log(err);
			}
			logstuff("deployment_branch: <b>" + deployment_branch + "</b>");
			logstuff("deployment_email: <b>" + deployment_email + "</b>");
			logstuff("deployment_codename: " + deployment_codename);
			logstuff("deployment_majorreleaseversion: " + deployment_majorreleaseversion);
			logstuff("deployment_minorreleaseversion: " + deployment_minorreleaseversion);
			logstuff("deployment_patchreleaseversion: " + deployment_patchreleaseversion);
			logstuff("deployment_deploytofirebase: " + deployment_deploytofirebase);
			
			if (deployment_deploytofirebase != "only") {
				// pull latest git repo down
				gitrepo_local_folder = jsondata[sitename].gitrepo_local_folder;
				logstuff("gitrepo_local_folder: " + gitrepo_local_folder);
				console.log("Pulling down git repo to " + gitrepo_local_folder);
				logstuff("Pulling down git repo to " + gitrepo_local_folder);
				var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'pullgitrepodown.sh ' + gitrepo_local_folder + ' ' + deployment_branch, {silent:true}).output;
				logstextarea(outputtext, 15);

				// delete templates.js
				console.log("Deleting templates.js from gitrepo");
				logstuff("Deleting templates.js from gitrepo");
				var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'rmtemplatesjs.sh', {silent:true}).output;
				logstextarea(outputtext, 2);
				
				// run npm install
				try {
					npm_install_folder = jsondata[sitename].npm_install_folder;
				}
				catch (e) {
					npm_install_folder = "";
				}
				logstuff("npm_install_folder: " + npm_install_folder);
				if((npm_install_folder != "") && (npm_install_folder)) {
					// check its for a prod site
					if (sitename.toLowerCase().indexOf("prod") > -1) {
						console.log("Deploying npm packages for production");
						logstuff("Deploying npm packages for production");
						var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'donmpinstall.sh ' + npm_install_folder + ' prod', {silent:true}).output;
						logstextarea(outputtext, 7);
					} else {
						console.log("Deploying npm packages");
						logstuff("Deploying npm packages");
						var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'donmpinstall.sh ' + npm_install_folder, {silent:true}).output;	
						logstextarea(outputtext, 7);
					}
					// run bower install
					console.log("running bower installation");
					logstuff("running bower installation");
					var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'dobowerinstall.sh ' + npm_install_folder, {silent:true}).output;	
					logstextarea(outputtext, 20);
				}

				// load template config file and make a clean one for the release
				config_file_template_name = jsondata[sitename].config_file.template_name;
				console.log('Creating node config based off template ' + config_file_template_name);
				logstuff('Creating node config based off template ' + config_file_template_name);
				wsconfigdata = fs.readFileSync(TEMPLATES_FOLDER_LOCATION + config_file_template_name).toString();

				logstuff("Config file template is as follows:");
				logstextarea(wsconfigdata, 15);
				
				config_file_destination_name = jsondata[sitename].config_file.destination_name;
				var jsonconfigfilereplacementsdata = jsondata[sitename].config_file.replacements;
				
				if (jsonconfigfilereplacementsdata != "") {
					for(var key in jsonconfigfilereplacementsdata){
						if(jsonconfigfilereplacementsdata.hasOwnProperty(key)) {
							wsconfigdata = wsconfigdata.replace('tbc_' + key, jsonconfigfilereplacementsdata[key]);
						}
					}
				}
				// replace build version info
				wsconfigdata = wsconfigdata.replace('mwsvar_code_name', deployment_codename);
				wsconfigdata = wsconfigdata.replace('mwsvar_major_release_version', deployment_majorreleaseversion);
				wsconfigdata = wsconfigdata.replace('mwsvar_minor_release_version', deployment_minorreleaseversion);
				wsconfigdata = wsconfigdata.replace('mwsvar_patch_release_version', deployment_patchreleaseversion);
				logstuff("New config file created:");
				logstextarea(wsconfigdata, 15);
				logstuff("Saving config file to: " + config_file_destination_name);
				fs.writeFileSync(config_file_destination_name, wsconfigdata);
		
				// run gulpbuildconfig
				console.log('running gulp build-config');
				logstuff("running gulp build-config");
				var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'gulpbuildconfig.sh ' + npm_install_folder, {silent:true}).output;	
				logstextarea(outputtext, 7);
				
				// run main gulp deployment job
				console.log("running main gulp deployment to " + site_environment);
				logstuff("running  main gulp deployment to " + site_environment);
				var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'rungulptodeploysite.sh /var/www/decidz/gitrepo/decidz-linuxserver/scripts/config/ ' + site_environment  + ' ' + deployment_branch, {silent:true}).output;	
				logstextarea(outputtext, 20);
				logstuff("Main gulp deployment finished");
				logstuff("Updating firebase build version for " + site_environment2);
				updatefirebasedata("/buildversion/" + site_environment2, {"code_name" : deployment_codename, "major_release_version" : deployment_majorreleaseversion, "minor_release_version" : deployment_minorreleaseversion, "patch_release_version" : deployment_patchreleaseversion});
				messageslackchannel("#build-and-issues", "Deployment to " + description + " complete (requested by " + deployment_email + ") - " + WEBSITE_LOGS_LOCATION + glogfilename);
			}
			if ((deployment_deploytofirebase == "yes") || (deployment_deploytofirebase == "only")) {
				// deploy site to firebase now
				console.log("Deploying " + site_environment + " to Firebase Hosting now!");
				logstuff("Deploying prefirebase.decidz.com to Firebase Hosting now!");
				var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'deployprodsitetofirebase.sh', {silent:true}).output;	
				logstextarea(outputtext, 10);
				logstuff("Firebase Hosting deployment done!");
				messageslackchannel("#build-and-issues", "Deployment of prefirebase.decidz.com to Firebase Hosting complete (requested by " + deployment_email + ") - " + WEBSITE_LOGS_LOCATION + glogfilename);
			}
		}
	}		
}


function deploynodesite(sitename) {
	var fs = require('fs');
	console.log("Loading details for site " + sitename);
	logstuff("Loading details for site " + sitename);
	messageslackchannel("#build-and-issues", "Deployment to " + description + " started - " + WEBSITE_LOGS_LOCATION + glogfilename);
	var jsondata = loadconfig();
	if (jsondata != "") {
		// see if the sitename exists in the json file
		try {
			description = jsondata[sitename].description;
		}
		catch (e) {
			description = "";
		}
		if((description != "") && (description)){
			console.log("Deploying " + description);
			logstuff("Deploying " + description);
			deployment_branch = "";
			deployment_email = "";
			try {
				var jsondeploymentdata = JSON.parse(fs.readFileSync(FLAGFILE_FOLDER + "deploy_" + sitename + ".processing", 'utf8'));
				deployment_branch = jsondeploymentdata.branch;
				deployment_email = jsondeploymentdata.useremail;
			} catch (err) {
				console.log(err);
			}
			logstuff("deployment_branch: " + deployment_branch);
			logstuff("deployment_email: " + deployment_email);
					
			// can now deploy site - first kill any processes for the site
			console.log("Killing script " + sitename + '_worker.js');
			logstuff("Killing script " + sitename + '_worker.js');
			output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'killnodescript.sh ' + sitename + '_worker.js');
			logstextarea(output, 3);
			
			// pull latest git repo down
			gitrepo_local_folder = jsondata[sitename].gitrepo_local_folder;
			console.log("Pulling down git repo to " + gitrepo_local_folder);
			logstuff("Pulling down git repo to " + gitrepo_local_folder);
			var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'pullgitrepodown.sh ' + gitrepo_local_folder + ' ' + deployment_branch, {silent:true}).output;
			logstextarea(outputtext, 10);
			
			// copy file repo over
			source_folder = jsondata[sitename].source_folder;
			node_website_root = jsondata[sitename].node_website_root;
			gitrepo_branch = deployment_branch;
			console.log("Copying folder " + gitrepo_local_folder + source_folder + " (" + gitrepo_branch + ") to " + node_website_root);
			logstuff("Copying folder " + gitrepo_local_folder + source_folder + " (" + gitrepo_branch + ") to " + node_website_root);
			var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'copyfolder.sh ' + gitrepo_local_folder + source_folder + " " + node_website_root + " " + gitrepo_branch, {silent:true}).output;
			logstextarea(outputtext, 10);
			
			// rename worker script
			main_worker_script = jsondata[sitename].main_worker_script;
			console.log('Renaming worker file to ' + sitename + '_worker.js');
			logstuff('Renaming worker file to ' + node_website_root + '/' + sitename + '_worker.js');
			fs.renameSync(node_website_root + main_worker_script, node_website_root + '/' + sitename + '_worker.js');

			// load template config file and make a clean one for the release
			config_file_template_name = jsondata[sitename].config_file.template_name;
			console.log('Creating node config based off template ' + config_file_template_name);
			logstuff('Creating node config based off template ' + config_file_template_name);
			nodeconfigdata = fs.readFileSync(TEMPLATES_FOLDER_LOCATION + config_file_template_name).toString();
			logstuff("Config file template is as follows:");
			logstextarea(nodeconfigdata, 15);
			
			config_file_destination_name = jsondata[sitename].config_file.destination_name;
			var jsonconfigfilereplacementsdata = jsondata[sitename].config_file.replacements;
			
			if (jsonconfigfilereplacementsdata != "") {
				for(var key in jsonconfigfilereplacementsdata){
					if(jsonconfigfilereplacementsdata.hasOwnProperty(key)) {
						nodeconfigdata = nodeconfigdata.replace('tbc_' + key, jsonconfigfilereplacementsdata[key]);
					}
				}
			}
			fs.writeFileSync(node_website_root + config_file_destination_name, nodeconfigdata);

			logstuff("New Config file created:");
			logstextarea(nodeconfigdata, 15);
			
			// run NPM install for node server if required
			try {
				npm_install_folder = jsondata[sitename].npm_install_folder;
			}
			catch (e) {
				npm_install_folder = "";
			}
			if((npm_install_folder != "") && (npm_install_folder)) {
				// check its for a prod site
				if (sitename.toLowerCase().indexOf("prod") > -1) {
					console.log("Deploying npm packages for production");
					logstuff("Deploying npm packages for production");
					var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'donmpinstall.sh ' + node_website_root + npm_install_folder + ' prod', {silent:true}).output;
					logstextarea(outputtext, 15);
				} else {
					console.log("Deploying npm packages");
					logstuff("Deploying npm packages");
					var outputtext = sh.exec(HELPERS_SCRIPTS_FOLDER_LOCATION + 'donmpinstall.sh ' + node_website_root + npm_install_folder, {silent:true}).output;	
					logstextarea(outputtext, 15);
				}					
			}

			// start the node worker process
			console.log("Starting node script " + sitename + '_worker.js');
			logstuff("Starting node script " + sitename + '_worker.js');
			output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'startnodescript.sh ' + node_website_root + ' ' + sitename + '_worker.js');
			logstextarea(output, 4);
			logstuff("Deployment complete");
			messageslackchannel("#build-and-issues", "Completed deployment of " + deployment_branch + " branch to " + description + " (requested by " + deployment_email + ") - " + WEBSITE_LOGS_LOCATION + glogfilename);
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

function messageslackchannel(slackchannel, slackmessage) {
	output = execSync(HELPERS_SCRIPTS_FOLDER_LOCATION + 'sendslackmessage.sh "' + slackchannel + '" "' + slackmessage + '"');
}

function addfirebaserecord(firebasekey, firebasedata){
	var ref = new Firebase(FIREBASEURL + firebasekey);
	ref.authWithCustomToken(FIREBASEAUTHCODE, function(error, errordata) {});	
    ref.push(firebasedata, function(error, errordata) {process.exit(0);});	
}

function updatefirebasedata(firebasekey, firebasedata){
	var ref = new Firebase(FIREBASEURL + firebasekey);
	ref.authWithCustomToken(FIREBASEAUTHCODE, function(error, errordata) {});	
    ref.update(firebasedata, function(error, errordata) {process.exit(0);});	
}


function installnginxsite(sitename) {
	var fs = require('fs');
	console.log("Loading details for site " + sitename);
	var jsondata = loadconfig();
	if (jsondata != "") {
		// see if the sitename exists in the json file
		try {
			description = jsondata[sitename].description;
		}
		catch (e) {
			description = "";
		}
		if(description != "") {
			console.log("Description: " + description);
			try {
				nginx_host_name = jsondata[sitename].nginx_host_name;
			}
			catch (e) {
				nginx_host_name = "";
			}
			if (nginx_host_name != "") {
				// need to deploy the nginx site - lets see if the nginx site is already deployed
				if (!fileexists(NGINX_SITES_AVAILABLE + sitename + ".conf")) {
					// load the node.js port
					console.log("Deploying NGINX site for " + sitename);
					node_listen_port = jsondata[sitename].config_file.replacements.node_listen_port;
					// copy template file over to sites-available folder and do replacements
					configdata = fs.readFileSync(NGINX_TEMPLATE_FILE).toString();
					configdata = configdata.replace('tbc_nginx_host_name', nginx_host_name);
					configdata = configdata.replace('tbc_node_listen_port', node_listen_port);
					fs.writeFileSync(NGINX_SITES_AVAILABLE + sitename + ".conf", configdata);
					// now create link file from sites-enabled folder
					require("fs").symlink(
						NGINX_SITES_AVAILABLE + sitename + ".conf",
						NGINX_SITES_ENABLED + sitename + ".conf",
						function (err) { console.log(err || "Symlink created"); }
					);
				}
			}
			// configure git stuff - leave for now assume done already!

			
		} else {
			console.log("Unable to find config for " + sitename);
		}
	}
}

// work out what we are trying to deploy here
var option1 = process.argv[2];
var option2 = process.argv[3];
var now = new Date();
var glogfilename = dateFormat(now, "yyyymmdd-HHMMss-") + Guid.raw() + ".html";

if (option1 == "installnginxsite") {
	if (option2 == "all") {
		installallnginxsites();		
	} else {
		installnginxsite(option2);
	}
} else if (option1 == "deploynodesite") {
	if (option2 == "all") {
//		deployallsites();	
	} else {
		deploynodesite(option2);
	}
} else if (option1 == "checkflagfiles") {
	checkfordeploymentflagfiles();
} else {
	console.log("Invalid options");
}