/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var state = require('./state');

module.exports = function results(mock, method) {
  
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
};