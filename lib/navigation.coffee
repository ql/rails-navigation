AR = require './active-record'
fs = require 'fs'

# Navigation class contains methods used to navigate on
# rails directory structure

module.exports =
class Navigation

  # Given a model name, returns the file path for that model.
  @modelFilePath: (model) ->
    "app/models/#{model}.rb"

  # Given a model name, returns the file path for the respective controller
  @controllerFilePath: (model) ->
    "app/controllers/#{AR.pluralize(model)}_controller.rb"

  @helperFilePath: (model) ->
    "app/helpers/#{AR.pluralize(model)}_helper.rb"

  # Given a model name, returns the migration that creates it
  # It only works for migrations with the name
  # Returns undefined if not found
  @migrationFilePath: (model) ->
    pluralized_model = AR.pluralize(model)
    files = fs.readdirSync atom.project.getPath() + "/db/migrate"
    for file in files
      if file.match new RegExp("[0-9]+_create_" + pluralized_model + "\.rb")
        return "db/migrate/#{file}"


  # This is the base method used to navigational purposes.
  # It returns the model name from the current file.
  @getModelName: (file) ->
    regexps = [
      /\/models\/(\w+)\.rb$/,
      /\/controllers\/(\w+)_controller\.rb$/,
      /\/views\/(\w+)\/.*rb$/,
      /\/helpers\/(\w+)_helper\.rb$/,
      /\/migrate\/[0-9]+_create_(\w+)\.rb$/,
      /\/migrate\/[0-9]+_add_\w+_to_(\w+)\.rb$/
    ]

    for regexp in regexps
      if match = file.match regexp
        return AR.singularize(match[1])

  # Acordingly to the selected Editor and the file path function passed as
  # parameter, this method opens a new tab.
  @goTo: (fileKind) ->
    if editor = atom.workspace.getActiveEditor()
      modelName = Navigation.getModelName editor.getPath()

      targetFile = switch fileKind
        when "model"
          @modelFilePath(modelName)
        when "controller"
          @controllerFilePath(modelName)
        when "helper"
          @helperFilePath(modelName)
        when "migration"
          @migrationFilePath(modelName)

      atom.workspaceView.open(targetFile)
