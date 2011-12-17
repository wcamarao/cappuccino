#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

assert = require 'assert'
filter = require './filter'
state = require './state'

require './upon'
require './matchers'
require './verify'

global.mock = (type) ->

  match = (method, parameters) ->
    for parameter, index in parameters
      matcher = state.matcherAt mock, method, index
      if matcher?.mismatches(parameter)
        fail method, matcher.expectedValue(), parameter, index
    state.increaseCount mock, method

  expect = (mock, method) ->
    state.bind mock, method
    mockedMethod = ->
      match method, arguments
      state.result(mock, method)?()

  mock = filter type, expect

fail = (method, expectation, argument, index) ->
  operator = "#{method}(), argument #{parseInt index}"
  message = "#{operator}, expected #{expectation}, but actually received #{argument}"
  assert.fail argument, expectation, message, operator