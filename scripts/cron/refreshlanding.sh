#!/bin/bash
echo "Refresh landing pages cache"
curl -m 10 "http://whatson.int.decidz.com/getData"
curl -m 10 "http://whatson.staging.decidz.com/getData"
curl -m 10 "http://whatson.decidz.com/getData"
