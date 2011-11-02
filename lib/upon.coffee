#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

filter = require './filter'
state = require './state'

global.upon = (mock) ->

  wrap = (upon, method) ->
    wrappedMethod = ->
      addMatchers method, arguments
      results method

  addMatchers = (method, parameters) ->
    state.addMatcher mock, method, index, match.identify(p) for p, index in parameters

  results = (method) ->

    thenReturn: (value) ->
      state.setResult mock, method, -> value

    thenThrow: (e) ->
      state.setResult mock, method, -> throw (if e instanceof Error then e else new Error(e))

    thenCall: (callback) ->
      state.setResult mock, method, callback

  filter mock, wrap