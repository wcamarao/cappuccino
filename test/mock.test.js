var it = module.exports;
var should = require('should');
var $ = require('../lib/mock')
  , mock = $.mock
  , when = $.when
  , verify = $.verify
  , any = $.any;

it['should mock only methods but not other property types'] = function() {
  
  var mockedObject = mock(sampleObject());
  
  mockedObject.should.not.have.property('bool');
  mockedObject.should.not.have.property('number');
  mockedObject.should.not.have.property('object');
  mockedObject.should.not.have.property('undef');
  mockedObject.should.not.have.property('string');
  
  mockedObject.should.have.property('get');
  mockedObject.get.should.be.a('function');
};

function sampleObject() {
  return {
    bool: true,
    number: 1,
    object: [],
    undef: undefined,
    string: 'some text',
    get: function() { return 0; }
  };
}