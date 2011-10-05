var it = module.exports;
var should = require('should');
var mockjs = require('../lib/mock');

var mock = mockjs.mock;

it['should mock only methods of concrete objects'] = function() {
  
  var mockedLog = mock({ entry: 'log entry', get: function() { return this.entry; } });
  mockedLog.should.not.have.property('entry');
  mockedLog.should.have.property('get');
  mockedLog.get.should.be.a('function');
};