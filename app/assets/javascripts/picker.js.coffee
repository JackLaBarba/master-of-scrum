random_index = (list) ->
  Math.floor(Math.random()*list.length)

app = angular.module("Picker", ["ngResource"])

app.factory "Scrummer", ["$resource", ($resource) ->
  $resource("/scrummers/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@PickerCtrl = ["$scope", "Scrummer", ($scope, Scrummer) ->
  $scope.scrummers = Scrummer.query()

  $scope.addScrummer = ->
    scrummer = Scrummer.save($scope.newScrummer)
    $scope.scrummers.push(scrummer)
    $scope.newScrummer = {}

  $scope.removeScrummer = (index) ->
    scrummer = $scope.scrummers[index]
    Scrummer.delete(scrummer)
    $scope.scrummers.splice(index, 1)

  $scope.pick = ->
    $scope.scrummers.map (scrummer) ->
      scrummer.master = false
    pool = $scope.scrummers
    scrummer = pool[random_index(pool)]
    scrummer.master = true

    dev_pool = $scope.scrummers.filter (scrummer) -> scrummer.team
    dev_pool.map (scrummer) ->
      scrummer.pair_number = false
    i = 2
    while dev_pool.length > 0
      pick_i = random_index(dev_pool)
      dev_pool[pick_i].pair_number = Math.floor(i/2)
      console.log("picking #{dev_pool[pick_i].name}: #{Math.floor(i/2)}")
      dev_pool.splice(pick_i, 1)
      i++

    console.log($scope.scrummers)

]
