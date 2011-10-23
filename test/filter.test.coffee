#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../lib/cappuccino').inject module.exports
filter = require '../lib/filter'
stub = require './stubs/stub'

$.it 'should filter object methods and attributes', ->

  object = stub.object()
  functionCallback = -> 'function'
  attributeCallback = -> 'attribute'

  filtered = filter object, functionCallback, attributeCallback

  filtered.should.have.property p for p in ['bool', 'number', 'object', 'undef', 'string', 'get', 'set']
  filtered[p].should.be.equal 'attribute' for p in ['bool', 'number', 'object', 'undef', 'string']
  filtered[p].should.be.equal 'function' for p in ['get', 'set']


$.it 'should filter only object methods with no attributeCallback', ->

  object = stub.object()
  functionCallback = -> 'function'

  filtered = filter object, functionCallback

  filtered.should.not.have.property p for p in ['bool', 'number', 'object', 'undef', 'string']
  filtered.should.have.property p for p in ['get', 'set']
  filtered[p].should.be.equal 'function' for p in ['get', 'set']