class OutputHelper
  constructor: (@footerStatus, @footerPanel)->
    @errors = []
    @formattedErrors = []
    @guardComplete = false

  check: (@data) ->
    formattedOutput = this.parseData()
    if /\[RSpec results\] Failed/i.test(formattedOutput)
      @guardComplete = true
      this.setCodeFailure()
    if /Finished in/i.test(formattedOutput)
      @guardComplete = true
      if /Failed examples:/i.test(formattedOutput)
        this.gatherErrors(formattedOutput)
      else
        this.setAsPassed()
    else if /guard\(main\)/i.test(formattedOutput)
      # End reached - set the complete to false so we can start again.
      @guardComplete = false
    else if @guardComplete
      # Do nothing - we have the errors but guard has not finished running.
    else
      this.setAsRunning()

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
    line = error.match(/rb:([0-9]+)/)
    if line
      err['line'] = line[1]
    else
      err['line'] = ''
    err['message'] = error.match(/#\s(.*)/)[1]
    return err

  setAsRunning: ->
    @footerStatus.setText('Running')
    @footerStatus.removeClasses()

  setAsPassed: ->
    this.setPassedFooterStatus()
    this.resetFooterPanel()

  setCodeFailure: ->
    @footerStatus.setText('Failed to run')
    @footerStatus.removeClass('guard-rspec-output-success')
    @footerStatus.addClass('guard-rspec-output-error')

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
