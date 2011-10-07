/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var matchers = require('./matchers')
  , results = require('./results')
  , state = require('./state');

module.exports = function inject(filter) {
  
  return function when(mock) {
    
    var wrapper = {};
    filter(mock, wrapper, wrap);
    
    function wrap(method) {
      return function wrappedMethod() {
        addMatchers(method, arguments);
        return results(mock, method);
      };
    }
    
    function addMatchers(method, arguments) {
      for (index in arguments) {
        var argument = arguments[index];
        state.addMatcher(mock, method, index, matchers.identify(argument));
      }
    }
    
    return wrapper;
  };
}