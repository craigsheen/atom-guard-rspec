class OutputHelper
  constructor: (@data, @footerStatus, @footerPanel)->
    @errors = []
    @formattedErrors = []

  check: ->
    formattedOutput = this.parseData()
    if /\[0G/i.test(formattedOutput)
      this.setAsRunning()
    if /Finished in/i.test(formattedOutput)
      if /Failed examples:/i.test(formattedOutput)
        this.gatherErrors(formattedOutput)
      else
        this.setAsPassed()

  parseData: ->
    String.fromCharCode.apply(null, @data)

  gatherErrors: (output) ->
    @errors = output.match(/rspec .*/g)
    @formattedErrors = @errors.map((error, i) =>
      return this.formatError error
    )

    this.setFailedFooterStatus()
    this.setFailedFooterPanel()

  formatError: (error) ->
    err = {}
    err['file'] = error.match(/\.\/[a-z\/\.\_]*/)[0]
    err['line'] = error.match(/rb:([0-9]+)/)[1]
    err['message'] = error.match(/#(.*)/)[1]
    return err

  setAsRunning: ->
    @footerStatus.setText('Running')
    @footerStatus.removeClasses()

  setAsPassed: ->
    this.setPassedFooterStatus()
    this.resetFooterPanel()

  setFailedFooterStatus: ->
    errorMessage = @errors.length + ' Error(s) found!'
    errorList = @errors.join('<br />')
    @footerStatus.setText(errorMessage)
    @footerStatus.removeClass('guard-rspec-output-success')
    @footerStatus.addClass('guard-rspec-output-error')

  setPassedFooterStatus: ->
    @footerStatus.setText('No Errors')
    @footerStatus.removeClass('guard-rspec-output-error')
    @footerStatus.addClass('guard-rspec-output-success')

  setFailedFooterPanel: ->
    @footerPanel.clear()
    @footerPanel.addErrors(@formattedErrors)

  resetFooterPanel: ->
    @footerPanel.reset()

module.exports = OutputHelper
