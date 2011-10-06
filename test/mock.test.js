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
  mocked.get.should.be.a('function');
};

it['should wrap methods in when(mock) context'] = function() {
  
  var wrapped = when(mock(stub.object()));
  
  wrapped.should.have.property('get');
  wrapped.get.should.be.a('function');
};

it['should provide wrapped when(mock) methods with results'] = function() {
  
  var results = when(mock(stub.object())).get();
  
  results.should.have.property('thenReturn');
  results.thenReturn.should.be.a('function');
  
  results.should.have.property('thenThrow');
  results.thenThrow.should.be.a('function');
};

it['should wrap methods in verify(mock) context'] = function() {
  
  var wrapped = verify(mock(stub.object()));
  
  wrapped.should.have.property('get');
  wrapped.get.should.be.a('function');
};

it['should provide wrapped verify(mock) methods with verifications'] = function() {
  
  var verifications = verify(mock(stub.object())).get();
  
  //verifications.should.have.property('once');
  //verifications.once.should.be.a('function');
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