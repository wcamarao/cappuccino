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
  , verify = $.verify;

it['should wrap methods in verify(mock) context'] = function() {
  
  var wrapped = verify(mock(stub.object()));
  
  wrapped.should.have.property('get');
  wrapped['get'].should.be.a('function');
};

it['should provide wrapped methods with verifications'] = function() {
  
  var verifications = verify(mock(stub.object())).get();
  
  //verifications.should.have.property('once');
  //verifications['once'].should.be.a('function');
};