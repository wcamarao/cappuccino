/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var should = require('should');
var matcher = require('./matcher');
var state = require('./state');

module.exports.mock = mock;
module.exports.when = when;

function mock(type) {
  
  var mock = {};
  state.setup(mock);
  for (method in type) {
    if (isFunction(type[method])) {
      mock[method] = expect(method);
    }
  }
  
  function expect(method) {
    state.bind(mock, method);
    return function mockedMethod() {
      match(method, arguments);
      return state.returnValue(mock, method);
    };
  }
  
  function match(method, arguments) {
    for (index in arguments) {
      var argument = arguments[index];
      var matcher = state.matcher(mock, method, index);
      if (has(matcher) && matcher.mismatches(argument)) {
        unexpectedArgument(method, matcher.value(), argument, index);
      }
    }
  }
  
  return mock;
}

function when(mock) {
  
  var wrapper = {};
  for (method in mock) {
    if (isFunction(mock[method])) {
      wrapper[method] = wrap(method);
    }
  }
  
  function wrap(method) {
    return function wrappedMethod() {
      matchers(method, arguments);
      return result(method);
    };
  }
  
  function matchers(method, arguments) {
    for (index in arguments) {
      var expectedValue = arguments[index];
      state.matcher(mock, method, index, matcher.equals(expectedValue));
    }
  }
  
  function result(method) {
    return {
      thenReturn: function(value) {
        state.returnValue(mock, method, value);
      }
    };
  }
  
  return wrapper;
}

function unexpectedArgument(method, expectation, argument, index) {
  var title = 'mock.'+method + '(), argument #'+(parseInt(index)+1);
  var description = 'expected '+expectation+', but received '+argument;
  fail(title, description);
}

function fail(title, description) {
  should.fail(description, title);
}

function isFunction(value) {
  return typeof value === 'function';
}

function has(value) {
  return typeof value !== 'undefined';
}