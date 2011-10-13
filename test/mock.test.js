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
  , verify = $.verify;

it['should mock methods but not other property types'] = function() {
  
  var original = stub.object()
    , mocked = mock(original);
  
  mocked.should.have.property('get');
  mocked.should.have.property('set');
  
  mocked['get'].should.be.a('function');
  mocked['set'].should.be.a('function');
  
  mocked.should.not.have.property('bool');
  mocked.should.not.have.property('number');
  mocked.should.not.have.property('object');
  mocked.should.not.have.property('undef');
  mocked.should.not.have.property('string');
};

it['should default method return values to undefined'] = function() {
  
  var mocked = mock(stub.object());
  
  should.strictEqual(mocked.get(), undefined);
  should.strictEqual(mocked.set(), undefined);
};

it['should diff original, mocked and wrapped methods'] = function () {
  
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