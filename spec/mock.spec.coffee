#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'mock', ->

  stub = require './support/stub'



  it 'should mock methods but not other property types', ->

    mocked = mock stub.object()
    methods = ['get', 'set']
    attributes = ['bool', 'number', 'object', 'undef', 'string']

    expect(mocked[p]).toBeUndefined for p in attributes
    expect(mocked[p]).toBeDefined() for p in methods
    expect(typeof mocked[p]).toBe 'function' for p in methods



  it 'should default method return values to undefined', ->

    mocked = mock stub.object()
    expect(mocked.get()).toBeUndefined()
    expect(mocked.set()).toBeUndefined()



  it 'should diff original, mock and wrapped methods', ->

    original = stub.object()
    mocked = mock original
    wrapped =
      upon: upon mocked
      verify: verify mocked

    expect(original.get).not.toBe mocked.get
    expect(original.get).not.toBe wrapped.upon.get
    expect(original.get).not.toBe wrapped.verify.get

    expect(mocked.get).not.toBe wrapped.upon.get
    expect(mocked.get).not.toBe wrapped.verify.get

    expect(wrapped.upon.get).not.toBe wrapped.verify.get