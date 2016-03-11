ChildProcess  = require 'child_process'
OutputHelper = require './output-helper'
StatusMessage = require './status-message'
GuardRspecOutput = require './guard-rspec-output'

module.exports =
class GuardRspecView
  constructor: (serializedState) ->
    @footerPanel = new GuardRspecOutput()
    @footerStatus = new StatusMessage()

    spawn = ChildProcess.spawn

    terminal = spawn("bash", ["-l"])

    projectPath = atom.project.getPaths()[0]
    command = "guard"

    terminal.stdout.on 'data', @handleOutput
    terminal.stdin.write("cd #{projectPath} && #{command}\n")

    @footerStatus.setText('Watching...')

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->

  handleOutput: (data) =>
    outputHelper = new OutputHelper(data, @footerStatus, @footerPanel)
    outputHelper.check()
