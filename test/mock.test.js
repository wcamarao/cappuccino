/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , should = require('should')
  , stub = require('./stubs/stub')
  , mock = require('../lib/mock').mock;

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