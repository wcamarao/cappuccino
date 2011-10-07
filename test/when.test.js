/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , should = require('should')
  , stub = require('./stubs/stub');

var $ = require('../lib/mock')
  , mock = $.mock
  , when = $.when;

it['should wrap methods in when(mock) context'] = function() {
  
  var wrapped = when(mock(stub.object()));
  
  wrapped.should.have.property('get');
  wrapped['get'].should.be.a('function');
};

it['should provide wrapped methods with results'] = function() {
  
  var results = when(mock(stub.object())).get();
  
  results.should.have.property('thenReturn');
  results['thenReturn'].should.be.a('function');
  
  results.should.have.property('thenThrow');
  results['thenThrow'].should.be.a('function');
  
  results.should.have.property('thenCall');
  results['thenCall'].should.be.a('function');
};

it['should stub a method to return a value'] = function() {
  
  var mocked = mock(stub.object())
    , expectedValue = 'some text';
  
  when(mocked).get().thenReturn(expectedValue);
  mocked.get().should.equal(expectedValue);
};

it['should stub a method to throw an error'] = function() {
  
  var mocked = mock(stub.object())
    , error = new Error('oops');
  
  when(mocked).get().thenThrow(error);
  
  try { mocked.get(); }
  catch (e) { should.strictEqual(error, e); }
};

it['should stub a method to call a callback'] = function() {
  
  var mocked = mock(stub.object())
    , expectedNumber = 0;
  
  function callback() {
    return expectedNumber + 1;
  }
  
  when(mocked).get().thenCall(callback);
  mocked.get().should.equal(1);
};