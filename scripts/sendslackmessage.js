var Slack = require('slack-node');

function messageslackchannel(slackchannel, slackmessage) {
	webhookUri = "https://hooks.slack.com/services/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";

	slack = new Slack();
	slack.setWebhook(webhookUri);
	
	slack.webhook({
	  channel: slackchannel,
	  username: "deployment",
	  text: slackmessage
	}, function(err, response) {
//	  console.log(response);
	});	
}

var option1 = process.argv[2];
var option2 = process.argv[3];

if ((option1 != "") && (option2 != "")) {
	messageslackchannel(option1, option2);
}