#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require '../lib/mock'
stub = require './stubs/stub'

describe 'mock', ->



  it 'should mock methods but not other property types', ->

    mock = $.mock stub.object()
    methods = ['get', 'set']
    attributes = ['bool', 'number', 'object', 'undef', 'string']
    
    expect(mock[p]).toBeUndefined for p in attributes
    expect(mock[p]).toBeDefined() for p in methods
    expect(typeof mock[p]).toBe 'function' for p in methods



  it 'should default method return values to undefined', ->

    mock = $.mock stub.object()
    expect(mock.get()).toBeUndefined()
    expect(mock.set()).toBeUndefined()



  it 'should diff original, mock and wrapped methods', ->

    original = stub.object()
    mock = $.mock original
    wrapped =
      when: $.when mock
      verify: $.verify mock

    expect(original.get).not.toBe mock.get
    expect(original.get).not.toBe wrapped.when.get
    expect(original.get).not.toBe wrapped.verify.get

    expect(mock.get).not.toBe wrapped.when.get
    expect(mock.get).not.toBe wrapped.verify.get

    expect(wrapped.when.get).not.toBe wrapped.verify.get