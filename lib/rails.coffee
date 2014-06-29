Navigation = require './navigation'

promise = null
module.exports =

  activate: (state) ->
    atom.workspaceView.command "rails:go-to-model", @goToModel
    atom.workspaceView.command "rails:go-to-controller", @goToController
    atom.workspaceView.command "rails:go-to-helper", @goToHelper
    atom.workspaceView.command "rails:go-to-migration", @goToMigration
    atom.workspaceView.command "rails:go-to-view", @goToView
    atom.workspaceView.command "rails:go-to-test", @goToTest

  goToModel: ->
    Navigation.goTo "model"

  goToController: ->
    Navigation.goTo "controller"

  goToHelper: ->
    Navigation.goTo "helper"

  goToMigration: ->
    Navigation.goTo "migration"

  goToView: ->
    Navigation.goTo "view"

  goToTest: ->
    Navigation.goTo "test"
