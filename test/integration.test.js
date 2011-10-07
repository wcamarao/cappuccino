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
  , when = $.when
  , verify = $.verify
  , any = $.any;

it['should match a method call with a given value'] = function() {
  
  var mocked = mock(stub.object())
    , givenValue = 'some text';
  
  when(mocked).get(givenValue).thenReturn(true);
  mocked.get(givenValue).should.equal(true);
};

it['should match a method call with any type'] = function() {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(any('object')).thenReturn(true);
  mocked.get([]).should.equal(true);
};

it['should not match a method call with invalid argument'] = function() {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(1).thenReturn(true);
  
  try { mocked.get(2); }
  catch (e) { should.strictEqual(1, e.expected); }
};

it['should not match a method call with a wrong type'] = function() {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(any('object')).thenReturn(true);
  
  try { mocked.get('a string'); }
  catch (e) { should.strictEqual(any('object').expectedValue(), e.expected); }
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