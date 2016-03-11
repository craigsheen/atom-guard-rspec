{MessagePanelView, LineMessageView} = require 'atom-message-panel'

module.exports =
class GuardRspecOutput
  constructor: () ->
    @messagePanel = new MessagePanelView
      title: 'Guard RSpec'
    this.attach()
    this.close()

  addErrors: (errors) ->
    this.clear()
    for error in errors
      @messagePanel.add new LineMessageView
        file: error['file']
        line: error['line']
        message: error['message']
        className: 'guard-rspec-output-error'

    this.attach()

  attach: () ->
    @messagePanel.attach()

  reset: () ->
    this.clear()
    this.close()

  clear: () ->
    @messagePanel.clear()

  close: () ->
    @messagePanel.close()
