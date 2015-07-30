#!/bin/bash
FLAGFILEFOLDER="/var/www/decidz/flagfiles"
GTFB_FILE="$FLAGFILEFOLDER/deploygittofirebase.flg"
GTS_FILE="$FLAGFILEFOLDER/deploygittostaging.flg"
STFB_FILE="$FLAGFILEFOLDER/deploystagingtofirebase.flg"
TVN_FILE="$FLAGFILEFOLDER/deploygittotvn.flg"
GULP_FILE="$FLAGFILEFOLDER/deploygittogulppipeline.flg"
PREPRODLOCATION="/var/www/decidz/websites/preprod"
PREFIREBASELOCATION="/var/www/decidz/websites/prefirebase"
PREPRODDOMAIN="http://preprod.decidz.com"
STAGINGLOCATION="/var/www/decidz/websites/staging"
LOCALGITREPOLOCATION="/var/www/decidz/gitrepo"
GITREPOLOCATION="https://github.com/solaise73/noodle"
CONFIGLOCATION="/var/www/decidz/scripts/config"

lockfile=/var/www/decidz/scripts/gittofirebase.lock

removeflagfiles() {
        rm $GTFB_FILE
   	    rm $GTS_FILE # remove other flag files as this does the lot
        rm $STFB_FILE
		rm $GULP_FILE
}

pullgitrepodown() {
        # pull git repo down to server
        cd $LOCALGITREPOLOCATION
        sudo git pull origin master

        # get git commit hash
        commithashline=$(git show | head -n 1)
        commithash="${commithashline:7}"
        echo "Repo version: $commithash"
		# =======================================================================================================================
}

copygittostaging() {
        # copy git repo to staging site
        rm -R $STAGINGLOCATION/www
        mkdir $STAGINGLOCATION/www
        sudo cp -R $LOCALGITREPOLOCATION/webapp/* $STAGINGLOCATION/www
        cp $CONFIGLOCATION/firebase_withcaching.json $STAGINGLOCATION/www/firebase.json
        cp $CONFIGLOCATION/staging/config.js $STAGINGLOCATION/www/config.js

		# update git build version
#        sed -i "s/{{config.version.full}}/$commithash/g" "$STAGINGLOCATION/www/templates/pages/menu.html"
}

copygittoholdingdirandgulpify() {
    if [ $1 == 'preprod' ]; then
		sitelocation=$PREPRODLOCATION
		siteflavour=$1
	elif [ $1 == 'prefirebase' ]; then
		sitelocation=$PREFIREBASELOCATION
		siteflavour='prod'
    fi

    echo "Deploying git repo to $siteflavour site"

	# copy repo to preprod folder
	echo "--> making copy of git repo under $sitelocation/www"
	rm -R $sitelocation/www
	mkdir $sitelocation/www
	sudo cp -R $LOCALGITREPOLOCATION/webapp/* $sitelocation/www
	cp $CONFIGLOCATION/firebase_withmegacaching.json $sitelocation/www/firebase.json
	
	# temp disable preprod using prod firebase whilst we push out major changes.
#        cp $CONFIGLOCATION/prod/config.js $sitelocation/www/config.js
	cp $CONFIGLOCATION/$siteflavour/config.js $sitelocation/www/config.js

	# update app.js prior to gulp pipeline to include reference to templates module
	echo "--> adding templates module to app.js"
	sed -i "s/'pascalprecht.translate',/'pascalprecht.translate','templates',/g" "$sitelocation/www/app.js"

	# update git build version prior to gulp pipeline to include git commit version
	echo "--> updating build version in menu.html to $commithash"
#        sed -i "s/{{config.version.full}}/$commithash/g" "$sitelocation/www/templates/pages/menu.html"

	# move datetimepicker.css to css folder and update index.html
	echo "--> moving datetimepicker.css to css folder and updating index.html"
	mv $sitelocation/www/bower_components/angular-bootstrap-datetimepicker/src/css/datetimepicker.css $sitelocation/www/css/datetimepicker.css
	sed -i "s/bower_components\/angular-bootstrap-datetimepicker\/src\/css\/datetimepicker.css/css\/datetimepicker.css/g" "$sitelocation/www/index.html"
	
	# run gulp commands
	echo "--> executing gulp tasks"
	cd $sitelocation
	gulp
	
	# update reference to js files in index.html with hashed cache busting name
	echo "--> updating js and css references in index.html"
	js1filename=$(cat $sitelocation/temp/jsb1/rev-manifest.json | jq '.["js1.js"]')
	js2filename=$(cat $sitelocation/temp/jsb2/rev-manifest.json | jq '.["js2.js"]')
	cssfilename=$(cat $sitelocation/temp/css/rev-manifest.json | jq '.["noodle-bootstrap.css"]')
	js1fnclean="${js1filename/\"/}"
	js1fnclean="${js1fnclean/\"/}"
	js2fnclean="${js2filename/\"/}"
	js2fnclean="${js2fnclean/\"/}"
	cssfnclean="${cssfilename/\"/}"
	cssfnclean="${cssfnclean/\"/}"
	sed -i "s/js1.js/$js1fnclean/g" "$sitelocation/www/index.html"
	sed -i "s/js2.js/$js2fnclean/g" "$sitelocation/www/index.html"
	sed -i "s/noodle-bootstrap.css/$cssfnclean/g" "$sitelocation/www/index.html"
	
	# remove old javascript and other files as no longer needed
	echo "--> removing files and folders no longer required"
	rm $sitelocation/www/app.js
	rm $sitelocation/www/js/templates.js
	rm $sitelocation/www/js/mobiscroll.custom-2.15.1.min.js
	rm $sitelocation/www/config.js
	rm $sitelocation/www/controllers.js
	rm $sitelocation/www/css/noodle-bootstrap.css

	# remove old folders no longer required
	rm -R $sitelocation/www/chat
	rm -R $sitelocation/www/css/less
	rm -R $sitelocation/www/home
	rm -R $sitelocation/www/leave
	rm -R $sitelocation/www/menu
	rm -R $sitelocation/www/factories
	rm -R $sitelocation/www/noodle
	rm -R $sitelocation/www/noodleedit
	rm -R $sitelocation/www/sync
	rm -R $sitelocation/www/who
	rm -R $sitelocation/www/create
	rm -R $sitelocation/www/close
	rm -R $sitelocation/www/join
	rm -R $sitelocation/www/js/modules
	rm -R $sitelocation/www/js/lib
	rm $sitelocation/www/js/typed.min.js
	rm $sitelocation/www/js/moment-timezone-with-data-2010-2020.js
	rm $sitelocation/www/js/mobiscroll.custom-2.15.1.min.js
	rm $sitelocation/www/js/rcMailgunValid.js
	rm $sitelocation/www/js/angular-toastr.tpls.js
	
	cp $sitelocation/www/bower_components/zeroclipboard/dist/ZeroClipboard.swf $sitelocation/www/ZeroClipboard.swf
	rm -R $sitelocation/www/bower_components
	mkdir -p $sitelocation/www/bower_components/zeroclipboard/dist/
	mv $sitelocation/www/ZeroClipboard.swf $sitelocation/www/bower_components/zeroclipboard/dist/ZeroClipboard.swf
#	chmod -R 766 $sitelocation/www/bower_components
}

deploytofirebasefrompreprod() {
       # deploy preprod site to firebase
        echo "Deploying preprod to firebase"
        cd $PREFIREBASELOCATION/www
        firebase deploy
}

# =======================================================================================================================
# START OF MAIN SCRIPT
# =======================================================================================================================
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null; then

    trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT
    # this instance of the script has a file lock so its the only instance running
    echo "--> Script locked and loaded";

    if [ -f $GTFB_FILE ]; then
        echo "Deploying git repo to firebase via preprod and staging"
		removeflagfiles
		pullgitrepodown
		copygittostaging
		copygittoholdingdirandgulpify "preprod"
		copygittoholdingdirandgulpify "prefirebase"
		deploytofirebasefrompreprod
        echo -e "GIT deployed to http://staging.decidz.com, http://preprod.decidz.com and https://decidz.com sites.\n\n\nCommit: $GITREPOLOCATION/commit/$commithash" | mutt -s "Decidz GIT deployed to firebase hosting" -- "devops@decidz.com"
    fi

    if [ -f $GTS_FILE ]; then
        echo "Deploying git repo to preprod and staging"
		removeflagfiles
		pullgitrepodown
		copygittostaging
		copygittoholdingdirandgulpify "preprod"
		copygittoholdingdirandgulpify "prefirebase"
        echo -e "GIT deployed to http://staging.decidz.com and http://preprod.decidz.com sites.\n\n\nCommit: $GITREPOLOCATION/commit/$commithash" | mutt -s "Decidz GIT deployed to preprod and staging" -- "devops@decidz.com"
    fi

    if [ -f $STFB_FILE ]; then
		removeflagfiles
		deploytofirebasefrompreprod
        echo "Preprod deployed to https://decidz.com" | mutt -s "Decidz preprod deployed to firebase hosting" -- "devops@decidz.com"
    fi

    # clean up after yourself, and release your trap
    rm -f "$lockfile"
    trap - INT TERM EXIT
    echo "--> Script complete";
else
    echo "--> Lock Exists: $lockfile owned by $(cat $lockfile)"
fi