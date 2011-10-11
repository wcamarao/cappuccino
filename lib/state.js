/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var api = module.exports
  , state = {};
  
state.indexes = [];
state.metadata = [];

function lookup(mock) {
  var i = state.indexes.indexOf(mock);
  if (i === -1) {
    var metadata = {};
    state.indexes.push(mock);
    state.metadata.push(metadata);
    return metadata;
  }
  return state.metadata[i];
}

api.bind = function(mock, method) {
  var metadata = lookup(mock);
  metadata.methods = metadata.methods || [];
  metadata.methods.push(method);
  metadata[method] = {};
  metadata[method].count = 0;
  metadata[method].matchers = [];
}

api.addMatcher = function(mock, method, index, matcher) {
  lookup(mock)[method].matchers[index] = matcher;
}

api.matcherAt = function(mock, method, index) {
  return lookup(mock)[method].matchers[index];
}

api.setResult = function(mock, method, result) {
  lookup(mock)[method].result = result;
}

api.result = function(mock, method) {
  return lookup(mock)[method].result;
}

api.increaseCount = function(mock, method) {
  lookup(mock)[method].count++;
}

api.count = function(mock, method) {
  return lookup(mock)[method].count;
}

api.methods = function(mock) {
  return lookup(mock).methods;
}