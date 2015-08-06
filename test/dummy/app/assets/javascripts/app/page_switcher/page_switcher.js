(function() {
  'use strict';

  angular.module('sampleApp')
    .directive('pageSwitcher', PageSwitcher)
    .controller('PageSwitcherCtrl', PageSwitcherCtrl);

  function PageSwitcher() {
    return {
      restrict: 'E',
      scope: {},
      template: '<div ng-repeat="page in ctrl.pages"><div ng-include="ctrl.buildPage(page)"></div></div>',
      controller: 'PageSwitcherCtrl',
      controllerAs: 'ctrl',
      bindToController: true
    };
  }

  function PageSwitcherCtrl() {
    var ctrl = this;
    var pages = [
      'erb_file.html',
      'haml_file.html',
      'html_file.html',
      'slim_file.html',
      'extensionless/erb_file.html',
      'extensionless/haml_file.html',
      'extensionless/slim_file.html',
      'naming_conflicts/erb_file.html',
      'naming_conflicts/haml_file.html',
      'naming_conflicts/html_file.html',
      'naming_conflicts/slim_file.html'
    ];
    var prefix = "app/views/";

    ctrl.pages = pages;
    ctrl.buildPage = buildPage;

    function buildPage(page) {
      return prefix + page;
    }
  }
})();
