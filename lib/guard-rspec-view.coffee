ChildProcess  = require 'child_process'
OutputHelper = require './output-helper'
StatusMessage = require './status-message'

module.exports =
class GuardRspecView
  constructor: (serializedState) ->
    @footerOutput = new StatusMessage('Starting Guard..')

    spawn = ChildProcess.spawn

    terminal = spawn("bash", ["-l"])

    # TODO: Change this back.
    # projectPath = atom.project.getPaths()[0]
    projectPath = "/Users/craigsheen/development/bellroy"
    command = "guard"

    terminal.stdout.on 'data', @handleOutput
    terminal.stdin.write("cd #{projectPath} && #{command}\n")

    @footerOutput.setText('Watching...')

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->

  getElement: ->

  handleOutput: (data) =>
    output_helper = new OutputHelper(data, @footerOutput)
    output_helper.check()
