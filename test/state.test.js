/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , should = require('should')
  , state = require('../lib/state');

it['should setup an empty state for a mock method'] = function() {
  
  var mock = {}
    , method = 'get';
  
  state.bind(mock, method);
  
  should.not.exist(state.result(mock, method));
  should.not.exist(state.matcherAt(mock, method, 0));
};

it['should set a result for a mock method'] = function() {
  
  var mock = {}
    , method = 'get'
    , result = 'result';
  
  state.bind(mock, method);
  state.setResult(mock, method, result);
  
  state.result(mock, method).should.equal(result);
};

it['should add matchers for mock method arguments'] = function() {
  
  var mock = {}
    , method = 'get'
    , firstMatcher = {}
    , secondMatcher = [];
  
  state.bind(mock, method);
  
  state.addMatcher(mock, method, 0, firstMatcher);
  state.addMatcher(mock, method, 1, secondMatcher);
  
  state.matcherAt(mock, method, 0).should.equal(firstMatcher);
  state.matcherAt(mock, method, 1).should.equal(secondMatcher);
};