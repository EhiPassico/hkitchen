myapp.controller('vacation_controller', ["$scope", "$filter", "$resource", function ($scope, $filter, $resource) {

    $scope.vac_date = new Date()
    $scope.show_update_button = false


    $scope.ajaxCall = function (route) {
        res = $resource('/' + route + '/:id/:action.json', {id: '@id', action: '@action'}, {
            _update: {method: 'PUT'},
            _delete: {method: '_delete'},
            _post: {method: 'POST'},
            _patch: {method: '_patch'},
            _get: {method: 'GET'}
        })

        return res
    }


    $scope.$watch("report_type", function () {
        $scope.vacations = []
        if ($scope.report_type == '1') {
            $scope.report_name = "Planned"
        } else if ($scope.report_type == '2') {
            $scope.report_name = "Completed"
        } else if ($scope.report_type == '3') {
            $scope.report_name = "Cancelled"
        }
        // $scope.schedule_report.data = []
        // $scope.trip_schedules_report_fetch()
        $scope.cancel_update();
        $scope.get_vacations($scope.report_type)
    })


    $scope.get_vacations = function (vacation_status) {
        $scope.ajaxCall("vacations").get({
            action: 'get_vacations_for_status',
            status: vacation_status
        }, function (result) {
            $scope.vacations = result.vacations
        })
    }

    // $scope.get_vacations(1)


    $scope.save_vacation = function () {
        if ($scope.vac_description != null) {
            $scope.ajaxCall('vacations')._post({
                action: 'create',
                vacation: {
                    vacation_date: $scope.vac_date,
                    description: $scope.vac_description
                }
            }, function (result) {
                if (result.status == 'success') {
                    $scope.vacations.push(result.vacation)
                    $scope.vac_description = null
                }
            })
        }
    }


    $scope.update_vacation_status = function (vacation_status, vacation_id) {
        $scope.ajaxCall('vacations')._post({
            action: 'update_status',
            vacation_id: vacation_id,
            status: vacation_status
        }, function (result) {
            if (result.status == 'success') {
                var found = $filter('filter')($scope.vacations, {id: vacation_id}, true);
                $scope.vacations.splice($scope.vacations.indexOf(found[0]), 1)
                $scope.reset_values();
            }
        })
    }


    $scope.update_vacation = function (vacation) {
        $scope.ajaxCall('vacations')._post({
            action: 'update',
            vacation: {
                id: $scope.vac_id,
                vacation_date: $scope.vac_date,
                description: $scope.vac_description
            }
        }, function (result) {
            if (result.status == 'success') {
                var found = $filter('filter')($scope.vacations, {id: $scope.vac_id}, true);
                $scope.vacations[$scope.vacations.indexOf(found[0])] = result.vacation
                $scope.reset_values();
            }
        })
    }

    $scope.edit_record = function (vacation) {
        $scope.vac_id = vacation.id
        $scope.vac_date = new Date(vacation.vacation_date)
        $scope.vac_description = vacation.description
        $scope.show_update_button = true
    }

    $scope.cancel_update = function () {
        $scope.reset_values()
    }

    $scope.reset_values = function () {
        $scope.vac_date = new Date()
        $scope.vac_description = null
        $scope.show_update_button = false
    }


}])