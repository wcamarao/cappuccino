/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var assert = require('assert')
  , state = require('./state')
  , $ = module.exports = require('./matchers');

$.when = require('./when')(filter);
$.verify = require('./verify')(filter);

$.mock = function(type) {
  
  var mock = filter(type, expect);
  
  function expect(mock, method) {
    state.bind(mock, method);
    return function mockedMethod() {
      match(method, arguments);
      var result = state.result(mock, method);
      return result ? result() : result;
    };
  }
  
  function match(method, arguments) {
    for (index in arguments) {
      var argument = arguments[index]
        , matcher = state.matcherAt(mock, method, index);
      if (has(matcher) && matcher.mismatches(argument)) {
        unexpectedArgument(method, matcher.expectedValue(), argument, index);
      }
    }
    state.increaseCount(mock, method);
  }
  
  return mock;
};

function filter(object, functionCallback, otherwiseCallback) {
  var mock = {};
  for (property in object) {
    if (isFunction(object[property])) {
      mock[property] = functionCallback(mock, property);
    } else if (isFunction(otherwiseCallback)) {
      mock[property] = otherwiseCallback(mock, property);
    }
  }
  return mock;
}

function unexpectedArgument(method, expectation, argument, index) {
  var operator = method+'(), argument #'+(parseInt(index)+1)
    , message = operator+', expected '+expectation+', but actually received '+argument;
  assert.fail(argument, expectation, message, operator);
}

function isFunction(value) {
  return typeof value === 'function';
}

function has(value) {
  return typeof value !== 'undefined';
}