(function() {
  angular.module('myApp', ['rails_templatecache'])
    .run(['$templateCache', function($templateCache) {
      console.log($templateCache);
    }]);
})();
