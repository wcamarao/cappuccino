#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'upon', ->

  stub = require './stubs/stub'



  it 'should wrap methods in upon(mock) context', ->

    wrapped = upon mock stub.object()
    stubMethods = ['get', 'set']
    expect(wrapped[p]).toBeDefined() for p in stubMethods
    expect(typeof wrapped[p]).toBe 'function' for p in stubMethods



  it 'should provide wrapped methods with results', ->

    results = upon(mock stub.object()).get()
    resultMethods = ['thenReturn', 'thenThrow', 'thenCall']
    expect(results[p]).toBeDefined() for p in resultMethods
    expect(typeof results[p]).toBe 'function' for p in resultMethods



  it 'should stub a method to return a value', ->

    mocked = mock stub.object()
    expectedValue = 'some text'
    upon(mocked).get().thenReturn expectedValue
    expect(mocked.get()).toBe expectedValue



  it 'should stub a method to throw an error', ->

    mocked = mock stub.object()
    error = new Error 'oops'
    expected = ''
    upon(mocked).get().thenThrow error
    try mocked.get()
    catch e then expected = e
    expect(expected).toBe error



  it 'should stub a method to call a callback', ->

    expectedNumber = 0
    mocked = mock stub.object()
    callback = -> expectedNumber++
    upon(mocked).set().thenCall callback
    mocked.set()
    expect(expectedNumber).toBe 1