/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var should = require('should')
  , state = require('./state')
  , matchers = require('./matchers')
  , when = require('./when')(filter)
  , verify = require('./verify')(filter);

var $ = module.exports;

  $.mock = mock;
  $.when = when;
  $.verify = verify;
  $.any = matchers.any;

function mock(type) {
  
  var mock = {};
  state.setup(mock);
  filter(type, mock, expect);
  
  function expect(method) {
    state.bind(mock, method);
    return function mockedMethod() {
      match(method, arguments);
      var result = state.result(mock, method);
      return result();
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
  }
  
  return mock;
}

function filter(object, mock, functionCallback, otherwiseCallback) {
  for (key in object) {
    if (isFunction(object[key])) {
      mock[key] = functionCallback(key);
    } else if (isFunction(otherwiseCallback)) {
      mock[key] = otherwiseCallback(key);
    }
  }
}

function unexpectedArgument(method, expectation, argument, index) {
  var operator = method+'(), argument #'+(parseInt(index)+1)
    , message = operator+', expected '+expectation+', but actually received '+argument;
  should.fail(argument, expectation, message, operator);
}

function isFunction(value) {
  return typeof value === 'function';
}

function has(value) {
  return typeof value !== 'undefined';
}