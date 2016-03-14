var fs = require('fs');
var WebPageTest = require('webpagetest');
var wpt = new WebPageTest('www.webpagetest.org', 'A.d6d3d6f2b12bcb800898c800e884c05a');
// var request = require('request');
// var request = require('request-sync');
var request = require('sync-request');
var sleep = require('sleep');
var DEVMODE = false;

function execwebpagetest(testurl) {
	wpt.runTest(testurl, function(err, data) {
		if (!err) {
			fs.writeFile("/var/www/decidz/temp/webpagetest.json", JSON.stringify(data), function(err) {
			}); 
			processresult(data);
		}
	});
}

function loadwebpagetestresults(resultsurl) {
	var res = request('GET', resultsurl);
	var wptResponse = JSON.parse(res.getBody('utf8'));	
	statusText = wptResponse.data.statusText;
	if (statusText !== undefined) {
		console.log(statusText);
		console.log("");
	}
	return wptResponse;
}


function  processresult(wptresult) {
//	console.log(wptresult);
	// process json response file
	wptcallcomplete = false;
	numwptchecks = 0;
	statusCode = wptresult.statusCode;
	statusText = wptresult.statusText;
	if ((statusCode == "200") && (statusText = "Ok")) {
		// webpagetest API call was successful.
		userUrl = wptresult.data.userUrl;
		jsonUrl = wptresult.data.jsonUrl;

		// wait for Async webpagetest request to complete
		jsonresponse = "";
		while ((!wptcallcomplete) && (numwptchecks < 19)) {
			if (numwptchecks > 0) {
				sleep.sleep(5);
			}
			numwptchecks++;
			console.log("test " + numwptchecks)
			jsonresponse = loadwebpagetestresults(jsonUrl);
			if (jsonresponse != "") {
				statusCode = jsonresponse.data.statusCode;
				if (statusCode === undefined) {
					statusCode = jsonresponse.statusCode;
				}
//				console.log ("statusCode: " + statusCode);
				if (statusCode == 200) {
					wptcallcomplete = true;
				}
			}
		}
		
		console.log("--> " + numwptchecks);
		// async requests complete - lets see if we have the data we want yet
		if (wptcallcomplete) {
			fs.writeFile("/var/www/decidz/temp/webpagetest_full.json", JSON.stringify(jsonresponse), function(err) {
			}); 
			console.log("--> " + jsonresponse);
		} else {
			console.log("Failure!");
		}
		
		
	} else {
		console.log("webpagetest call failure");	
	}
}


var option1 = process.argv[2];

if (option1 != "") {
	if (DEVMODE) {
		// process from saved JSON file - avoids using webpagetest API quota
		console.log("Running in dev mode - loading JSON file");
		fs.readFile('/var/www/decidz/temp/webpagetest.json', 'utf8', function (err,data) {
			if (err) {
				return console.log(err);
			}
			processresult(JSON.parse(data));
		});			
	} else {
		console.log("Running in live mode - calling webpagetest.org");
		// actually run the webpage test and process response
		execwebpagetest(option1);
		
	}


}
