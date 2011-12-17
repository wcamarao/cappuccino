#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

state = {}
api = module.exports

state.indexes = []
state.metadata = []

lookup = (mock) ->
  if (i = state.indexes.indexOf mock) >= 0
    state.metadata[i]
  else
    metadata = {}
    state.indexes.push mock
    state.metadata.push metadata
    metadata

api.bind = (mock, method) ->
  metadata = lookup mock
  metadata.methods = metadata.methods or []
  metadata.methods.push method
  metadata[method] = {}
  metadata[method].count = 0
  metadata[method].matchers = []

api.addMatcher = (mock, method, index, matcher) ->
  lookup(mock)[method].matchers[index] = matcher

api.matcherAt = (mock, method, index) ->
  lookup(mock)[method].matchers[index]

api.setResult = (mock, method, result) ->
  lookup(mock)[method].result = result

api.result = (mock, method) ->
  lookup(mock)[method].result

api.increaseCount = (mock, method) ->
  lookup(mock)[method].count++

api.count = (mock, method) ->
  lookup(mock)[method].count

api.methods = (mock) ->
  lookup(mock).methods