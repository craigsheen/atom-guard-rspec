class OutputHelper
  constructor: (@data, @footerOutput)->
    @errors = []

  check: ->
    formatted_output = this.parseData()
    if /Finished in/i.test(formatted_output)
      if /Failed examples:/i.test(formatted_output)
        this.gatherErrors(formatted_output)
      else
        this.setAsPassed()

  parseData: ->
    String.fromCharCode.apply(null, @data)

  gatherErrors: (output) ->
    @errors = output.match(/rspec .*/g)
    errorMessage = @errors.length + ' Error(s) found!'
    errorList = @errors.join('<br />')
    @footerOutput.setText(errorMessage)
    @footerOutput.addClass('guard-rspec-output-error')
    @footerOutput.addHover(errorList)

  setAsPassed: ->
    @footerOutput.setText('No Errors')
    @footerOutput.removeClass('guard-rspec-output-error')
    @footerOutput.addClass('guard-rspec-output-success')
    @footerOutput.removeHover()

module.exports = OutputHelper
