#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'filter', ->

  filter = require '../lib/filter'
  stub = require './support/stub'



  it 'should filter object methods and attributes when using two callbacks', ->

    functionCallback = -> 'function'
    attributeCallback = -> 'attribute'

    filtered = filter stub.object(), functionCallback, attributeCallback

    expect(filtered[p]).toBeDefined() for p in ['bool', 'number', 'object', 'undef', 'string', 'get', 'set']
    expect(filtered[p]).toBe 'attribute' for p in ['bool', 'number', 'object', 'undef', 'string']
    expect(filtered[p]).toBe 'function' for p in ['get', 'set']



  it 'should filter only object methods when using one callback', ->

    functionCallback = -> 'function'

    filtered = filter stub.object(), functionCallback

    expect(filtered[p]).toBeUndefined() for p in ['bool', 'number', 'object', 'undef', 'string']
    expect(filtered[p]).toBeDefined() for p in ['get', 'set']
    expect(filtered[p]).toBe 'function' for p in ['get', 'set']



  it 'should fail when no callback is provided', ->

    message = undefined

    try filter stub.object()
    catch e then message = e.message

    expect(message).toBe 'filter: invalid functionCallback'



  it 'should fail when no object is provided', ->

    message = undefined

    try filter()
    catch e then message = e.message

    expect(message).toBe 'filter: invalid object'