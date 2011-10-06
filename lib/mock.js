/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var should = require('should')
  , matchers = require('./matchers')
  , state = require('./state');

var $ = module.exports;

  $.mock = mock;
  $.when = when;
  $.verify = verify;
  $.any = matchers.any;

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
      var result = state.result(mock, method);
      if (result instanceof Error) throw result;
      return result;
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

function when(mock) {
  
  var wrapper = filter(mock, wrap);
  
  function wrap(method) {
    return function wrappedMethod() {
      matchers(method, arguments);
      return results(method);
    };
  }
  
  function matchers(method, arguments) {
    for (index in arguments) {
      var argument = arguments[index];
      state.addMatcher(mock, method, index, matchers.identify(argument));
    }
  }
  
  function results(method) {
    return {
      thenReturn: function(value) {
        state.setResult(mock, method, value);
      },
      thenThrow: function(e) {
        state.setResult(mock, method, e instanceof Error ? e : new Error(e));
      }
      /*
      thenCall(fn, args)
      */
    };
  }
  
  return wrapper;
}

function verify(mock) {
  
  var wrapper = filter(mock, wrap);
  
  function wrap(method) {
    return function wrappedMethod() {
      return verifications(method);
    };
  }
  
  function verifications(method) {
    return {
      /*
        once()
        twice()
        times(x)
        atLeast(x)
        atMost(x)
        between(x,y)
        allowing()
        ignoring()
        never()
        only()
      */
    };
  }
  
  return wrapper;
}

function filter(mock, wrap) {
  var wrapper = {};
  for (method in mock) {
    if (isFunction(mock[method])) {
      wrapper[method] = wrap(method);
    }
  }
  return wrapper;
}

function unexpectedArgument(method, expectation, argument, index) {
  fail(method + '(), argument #'+(parseInt(index)+1),
    'expected '+expectation+', but actually received '+argument);
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