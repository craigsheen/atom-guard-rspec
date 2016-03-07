OutputHelper = require '../lib/output-helper'
StatusMessage = require '../lib/status-message'

describe 'OutputHelper', ->
  [outputHelper, statusBar] = []
  passingData = [27, 91, 48, 71, 91, 49, 93, 32, 103, 117, 97, 114, 100, 40, 109, 97, 105, 110, 41, 62, 32]
  failingData = [70, 105, 110, 105, 115, 104, 101, 100, 32, 105, 110, 32, 49, 46, 48, 56, 32, 115, 101, 99, 111, 110, 100, 115, 32, 40, 102, 105, 108, 101, 115, 32, 116, 111, 111, 107, 32, 49, 48, 46, 53, 32, 115, 101, 99, 111, 110, 100, 115, 32, 116, 111, 32, 108, 111, 97, 100, 41, 10, 49, 51, 32, 101, 120, 97, 109, 112, 108, 101, 115, 44, 32, 49, 32, 102, 97, 105, 108, 117, 114, 101, 115, 10, 10, 70, 97, 105, 108, 101, 100, 32, 101, 120, 97, 109, 112, 108, 101, 115, 58, 10, 10, 114, 115, 112, 101, 99, 32, 46, 47, 115, 112, 101, 99, 47, 109, 111, 100, 101, 108, 115, 47, 116, 101, 115, 116, 95, 115, 112, 101, 99, 46, 114, 98, 58, 50, 32, 35, 32, 116, 114, 117, 101, 32, 115, 104, 111, 117, 108, 100, 32, 101, 113, 117, 97, 108, 32, 102, 97, 108, 115, 101]

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise ->
      atom.packages.activatePackage('status-bar')

    runs ->
      statusBar = document.querySelector 'status-bar'

  it 'sets the data variable and footerOutput', ->
    statusMessage = new StatusMessage('message')
    outputHelper = new OutputHelper(passingData, statusMessage)

    expect(outputHelper.data).toEqual(passingData)
    expect(outputHelper.footerOutput).toBe(statusMessage)

  describe '#check', ->
    describe 'no failing specs', ->
      it 'should call the setAsPassed method', ->
        statusMessage = new StatusMessage('message')
        outputHelper = new OutputHelper(passingData, statusMessage)

        spyOn(outputHelper, 'setAsPassed')

        outputHelper.check()

        expect(outputHelper.setAsPassed).toHaveBeenCalled()

    describe 'with failing specs', ->
      it 'should call the gatherErrors method', ->
        statusMessage = new StatusMessage('message')
        outputHelper = new OutputHelper(failingData, statusMessage)

        spyOn(outputHelper, 'gatherErrors')

        outputHelper.check()

        expect(outputHelper.gatherErrors).toHaveBeenCalled()

  describe '#parseData', ->
    it 'should convert the data to a string', ->
      statusMessage = new StatusMessage('message')
      outputHelper = new OutputHelper(passingData, statusMessage)

      expect(outputHelper.parseData()).toEqual("[0G[1] guard(main)> ")

  describe '#gatherErrors', ->
    it 'sets errors', ->
      statusMessage = new StatusMessage('message')
      outputHelper = new OutputHelper(failingData, statusMessage)

      outputHelper.gatherErrors()

      expect(outputHelper.errors).toEqual(['rspec ./spec/models/test_spec.rb:2 # true should equal false'])

    it 'should set status message text', ->
      statusMessage = new StatusMessage('message')
      outputHelper = new OutputHelper(failingData, statusMessage)

      outputHelper.gatherErrors()

      expect(statusMessage.item.innerHTML).toEqual('1 Error(s) found!')

  describe '#setAsPassed', ->
    it 'should set status message text', ->
      statusMessage = new StatusMessage('message')
      outputHelper = new OutputHelper(passingData, statusMessage)

      outputHelper.setAsPassed()

      expect(statusMessage.item.innerHTML).toEqual('No Errors')
