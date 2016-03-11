GuardRspecOutput = require '../lib/guard-rspec-output'

describe 'GuardRspecOutput', ->
  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    guardRspecOutput = new GuardRspecOutput()

    waitsForPromise ->

    runs ->

  describe '#addErrors', ->
    it 'should clear the panel', ->
      spyOn(guardRspecOutput, 'clear')

      guardRspecOutput.addErrors([])

      expect(guardRspecOutput.clear).toHaveBeenCalled()

    it 'should add the errors and show the panel', ->
      guardRspecOutput.addErrors([{ 'file': 'something.rb', 'line': '2', 'message': 'error' }])

      expect(workspaceElement.querySelector('.guard-rspec-output-error')).toExist()
      expect(workspaceElement.querySelector('.line-message').count).toEqual 1

  describe '#reset', ->
    guardRspecOutput.addErrors([{ 'file': 'something.rb', 'line': '2', 'message': 'error' }])

    expect(workspaceElement.querySelector('.guard-rspec-output-error')).toExist()

    guardRspecOutput.reset()

    expect(workspaceElement.querySelector('.guard-rspec-output-error')).not.toExist()
