/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , should = require('should')
  , stub = require('./stub');

var $ = require('../lib/mock')
  , mock = $.mock
  , when = $.when
  , verify = $.verify
  , any = $.any;

it['should mock only methods but not other property types'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.should.not.have.property('bool');
  mocked.should.not.have.property('number');
  mocked.should.not.have.property('object');
  mocked.should.not.have.property('undef');
  mocked.should.not.have.property('string');
  
  mocked.should.have.property('get');
  mocked['get'].should.be.a('function');
};

it['should wrap methods in when(mock) context'] = function() {
  
  var wrapped = when(mock(stub.object()));
  
  wrapped.should.have.property('get');
  wrapped['get'].should.be.a('function');
};

it['should provide wrapped when(mock) methods with results'] = function() {
  
  var results = when(mock(stub.object())).get();
  
  results.should.have.property('thenReturn');
  results['thenReturn'].should.be.a('function');
  
  results.should.have.property('thenThrow');
  results['thenThrow'].should.be.a('function');
  
  results.should.have.property('thenCall');
  results['thenCall'].should.be.a('function');
};

it['should wrap methods in verify(mock) context'] = function() {
  
  var wrapped = verify(mock(stub.object()));
  
  wrapped.should.have.property('get');
  wrapped['get'].should.be.a('function');
};

it['should provide wrapped verify(mock) methods with verifications'] = function() {
  
  var verifications = verify(mock(stub.object())).get();
  
  //verifications.should.have.property('once');
  //verifications['once'].should.be.a('function');
};

it['should diff original, mocked and wrapped methods'] = function() {
  
  var original = stub.object()
    , mocked = mock(original)
    , wrapped = {};
  
  wrapped.when = when(mocked);
  wrapped.verify = verify(mocked);
  
  original.get.should.not.equal(mocked.get);
  original.get.should.not.equal(wrapped.when.get);
  original.get.should.not.equal(wrapped.verify.get);
  
  mocked.get.should.not.equal(wrapped.when.get);
  mocked.get.should.not.equal(wrapped.verify.get);
  
  wrapped.when.get.should.not.equal(wrapped.verify.get);  
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

it['should match a method call with any type'] = function() {
  
  var mocked = mock(stub.object())
    , anyObject = [];
  
  when(mocked).get(any('object')).thenReturn(true);
  mocked.get(anyObject).should.equal(true);
};

it['should not match a method call with invalid argument'] = function() {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(1).thenReturn(1);
  
  try { mocked.get(2); }
  catch (e) { should.strictEqual(1, e.expected); }
};

it['should not match a method call with a wrong type'] = function() {
  
  var mocked = mock(stub.object())
    , aString = 'some text';
  
  when(mocked).get(any('object')).thenReturn(true);
  
  try { mocked.get(aString); }
  catch (e) { should.strictEqual(any('object').expectedValue(), e.expected); }
};