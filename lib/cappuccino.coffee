#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

require 'should'

module.exports = inject: (testModuleExports) ->

  api = require './mock'
  before = undefined

  api.it = (statement, callback) ->
    testModuleExports[statement] = ->
      before?()
      callback()

  api.before = (b) ->
    before = b

  api