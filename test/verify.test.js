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
  
  var verifications = verify(mock(stub.object())).get()
    , methods = ['allowing', 'never', 'once', 'twice', 'times', 'atLeast', 'atMost', 'between', 'only'];
  
  methods.forEach(function (method) {
    verifications.should.have.property(method);
    verifications[method].should.be.a('function');
  });
};

// allowing

it['should verify that a method is always allowed to be called'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  
  verify(mocked).get().allowing();
};

// never

it['should verify that a method has never been called'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).set().never();
};

it['should fail verifying that a method has never been called'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).get().never().shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('never');
  });
};

// once

it['should verify that a method has been called once'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).get().once();
};

it['should fail verifying that a method has been called once'] = function() {
  
  var mocked = mock(stub.object());
  
  verify(mocked).get().once().shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('once');
  });
};

// twice

it['should verify that a method has been called twice'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  
  verify(mocked).get().twice();
};

it['should fail verifying that a method has been called twice'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).get().twice().shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('twice');
  });
};

// times

it['should verify that a method has been called n times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.set();
  mocked.set();
  mocked.set();
  
  verify(mocked).set().times(3);
};

it['should fail verifying that a method has been called n times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  
  verify(mocked).get().times(3).shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('3 time(s)');
  });
};

// at least

it['should verify that a method has been called at least n times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  mocked.get();
  
  verify(mocked).get().atLeast(0);
  verify(mocked).get().atLeast(1);
  verify(mocked).get().atLeast(2);
  verify(mocked).get().atLeast(3);
};

it['should fail verifying that a method has been called at least n times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).get().atLeast(2).shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('at least 2 time(s)');
  });
};

// at most

it['should verify that a method has been called at most n times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  mocked.get();
  
  verify(mocked).get().atMost(3);
  verify(mocked).get().atMost(4);
};

it['should fail verifying that a method has been called at most n times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  
  verify(mocked).get().atMost(1).shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('at most 1 time(s)');
  });
};

// between

it['should verify that a method has been called between n1 and n2 times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  
  verify(mocked).get().between(0, 2);
  verify(mocked).get().between(0, 3);
  verify(mocked).get().between(1, 2);
  verify(mocked).get().between(1, 3);
  verify(mocked).get().between(2, 2);
};

it['should fail verifying that a method has been called between n1 and n2 times'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  mocked.get();
  
  verify(mocked).get().between(0, 1).shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('between 0 and 1 time(s)');
  });
  
  verify(mocked).get().between(3, 3).shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('between 3 and 3 time(s)');
  });
};

// only

it['should verify that a method has been the only one called'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).get().only();
};

it['should fail verifying that a method has been the only one called'] = function() {
  
  var mocked = mock(stub.object());
  
  mocked.get();
  
  verify(mocked).set().only().shouldThrow(function (e) {
    e.should.be.instanceof(Error);
    e.expected.should.be.equal('should not call get()');
  });
};