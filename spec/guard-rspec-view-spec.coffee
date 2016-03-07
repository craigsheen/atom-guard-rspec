GuardRspecView = require '../lib/guard-rspec-view'

describe 'GuardRspecView', ->
  [statusBar] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise ->
      atom.packages.activatePackage('status-bar')

    runs ->
      statusBar = document.querySelector 'status-bar'

  it 'displays a message in the status bar', ->
    spyOn(statusBar, 'addLeftTile')

    new GuardRspecView()

    expect(statusBar.addLeftTile).toHaveBeenCalled()

  # TODO: Look at mocking and mock terminal stdout.
