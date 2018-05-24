// myapp = angular.module('myapp').run(["$rootScope", function ($rootScope) {


myapp = angular.module('myapp', ['ngResource', 'ngRoute'])


// var myApp = angular.module('myApp', [])
// }])

myapp.config(["$routeProvider", "$httpProvider", function ($routeProvider, $httpProvider) {
    $routeProvider
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
}])
