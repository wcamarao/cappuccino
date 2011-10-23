#
# mock.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

matchers = require './matchers'
filter = require './filter'
state = require './state'

module.exports = (mock) ->

  wrap = (upon, method) ->
    wrappedMethod = ->
      addMatchers method, arguments
      results method

  addMatchers = (method, parameters) ->
    state.addMatcher mock, method, index, matchers.identify(p) for p, index in parameters

  results = (method) ->

    thenReturn: (value) ->
      state.setResult mock, method, -> value

    thenThrow: (e) ->
      state.setResult mock, method, -> throw (if e instanceof Error then e else new Error(e))

    thenCall: (callback) ->
      state.setResult mock, method, callback

  filter mock, wrap