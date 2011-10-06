var it = module.exports;
var should = require('should');
var mockjs = require('../lib/mock');
var mock = mockjs.mock;

it['should mock only methods but not other types of properties'] = function() {
  
  var mockedObject = mock(sampleObject());
  
  mockedObject.should.not.have.property('id');
  mockedObject.should.not.have.property('array');
  mockedObject.should.not.have.property('object');
  mockedObject.should.not.have.property('bool');
  mockedObject.should.not.have.property('nill');
  mockedObject.should.not.have.property('undef');
  mockedObject.should.not.have.property('date');
  mockedObject.should.not.have.property('entry');
  
  mockedObject.should.have.property('get');
  mockedObject.get.should.be.a('function');
};

function sampleObject() {
  return {
    id: 1,
    array: [],
    object: {},
    bool: true,
    nill: null,
    undef: undefined,
    date: new Date(),
    entry: 'some text',
    get: function() { return 0; }
  };
}