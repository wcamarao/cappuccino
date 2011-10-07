/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var matchers = require('./matchers')
  , state = require('./state');

module.exports = function inject(filter) {
  
  return function when(mock) {
    
    var when = filter(mock, wrap);
    
    function wrap(when, method) {
      return function wrappedMethod() {
        addMatchers(method, arguments);
        return results(method);
      };
    }
    
    function addMatchers(method, arguments) {
      for (index in arguments) {
        state.addMatcher(mock, method, index, matchers.identify(arguments[index]));
      }
    }
    
    function results(method) {
      return {
        
        thenReturn: function(value) {
          state.setResult(mock, method, function() {
            return value;
          });
        },
        
        thenThrow: function(e) {
          state.setResult(mock, method, function() {
            throw e instanceof Error ? e : new Error(e);
          });
        },
        
        thenCall: function(callback) {
          state.setResult(mock, method, function() {
            return callback();
          });
        }
      };
    }
    
    return when;
  };
}