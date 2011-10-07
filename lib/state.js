/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var api = module.exports
  , state = {};

api.bind = function(mock, method) {
  state[mock] = state[mock] || {};
  state[mock][method] = {};
  state[mock][method].matchers = [];
}

api.addMatcher = function(mock, method, index, matcher) {
  state[mock][method].matchers[index] = matcher;
}

api.matcherAt = function(mock, method, index) {
  return state[mock][method].matchers[index];
}

api.setResult = function(mock, method, result) {
  state[mock][method].result = result;
}

api.result = function(mock, method) {
  return state[mock][method].result;
}