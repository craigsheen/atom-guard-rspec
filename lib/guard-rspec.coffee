GuardRspecView = require './guard-rspec-view'
{CompositeDisposable} = require 'atom'

module.exports = GuardRspec =
  guardRspecView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @guardRspecView = new GuardRspecView(state.guardRspecViewState)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'guard-rspec:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()
    @guardRspecView.destroy()

  serialize: ->
    guardRspecViewState: @guardRspecView.serialize()

  toggle: ->
