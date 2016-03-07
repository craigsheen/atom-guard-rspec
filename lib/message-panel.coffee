{MessagePanelView, LineMessageView} = require 'atom-message-panel'

class MessagePanel
  constructor: (@errors) ->
    @messagePanelView = new MessagePanelView
    this.addLine(@errors) if @errors?

  addErrors: (errors) ->
    for error in errors
      @messagePanelView.add new LineMessageView
        line: error['line']
        message: error['message']
