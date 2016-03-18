# Taken from: https://github.com/lee-dohm/package-sync/blob/master/spec/status-message-spec.coffee
module.exports =
class StatusMessage
  constructor: (message) ->
    @statusBar = document.querySelector('status-bar')
    if @statusBar
      @item = document.createElement('div')
      @item.classList.add('inline-block')
      @item.classList.add('guard-rspec-output')
      @setText(message)

      @tile = @statusBar.addLeftTile({ @item })

  remove: ->
    @tile?.destroy()
    @errorTooltip?.dispose()

  setText: (text) ->
    @item.innerHTML = text if @statusBar

  getText: ->
    @item.innerHTML

  addClass: (className) ->
    @item.classList.add(className)

  removeClass: (className) ->
    @item.classList.remove(className)

  removeClasses: ->
    @item.classList.remove('guard-rspec-output-success')
    @item.classList.remove('guard-rspec-output-error')
