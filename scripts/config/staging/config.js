'use strict';

angular.module('noodleApp.config', [])


.constant("ndlConfig", {
    "firebaseUrl": "https://noodlefusion.firebaseio.com",
    "decidzapi": "http://api.staging.decidz.com"
})
.directive('noodleDebugRemoveThisToDebug', function() {
  return {
    templateUrl: 'templates/debug.html'
  }
})
.controller('DebugController', function (ndlConfig, $scope, $rootScope, $firebaseArray, $location, noodleParams) {
	
	$scope.toggleMin = function() {
		$('#noodle-debug').toggleClass('min')
	}
	
	
})
