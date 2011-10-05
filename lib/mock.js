/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var expectations = {};

module.exports.mock = function(type) {
  var mock = {};
  for (method in type) {
    mock[method] = function() {
      for (index in arguments) {
        var argument = arguments[index];
        var expectation = expectations[mock][method]['arguments'][index];
        if (typeof expectation !== 'undefined' && argument !== expectation) {
          var title = 'mock.'+method + '(), argument #'+(parseInt(index)+1);
          var description = ', expected '+expectation+', received '+argument;
          should.fail(description, title);
        }
      }
      return expectations[mock][method]['returnValue'];
    }
  }
  return mock;
}

module.exports.when = function(mock) {
  var mockWrapper = {};
  for (method in mock) {
    expectations[mock] = expectations[mock] || {};
    expectations[mock][method] = expectations[mock][method] || {};
    mockWrapper[method] = function() {
      expectations[mock][method]['arguments'] = arguments;
      return {
        thenReturn: function(value) {
          expectations[mock][method]['returnValue'] = value;
        }
      };
    };
  }
  return mockWrapper;
}