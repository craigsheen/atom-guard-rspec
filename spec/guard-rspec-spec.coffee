GuardRspec = require '../lib/guard-rspec'

describe "GuardRspec", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('guard-rspec')

  describe "when the guard-rspec:toggle event is triggered", ->
    it "it starts a new instance of Guard Rspec View", ->
      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'guard-rspec:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
