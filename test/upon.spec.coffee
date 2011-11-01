#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require '../lib/mock'
stub = require './stubs/stub'

describe 'upon', ->



  it 'should wrap methods in upon(mock) context', ->

    wrapped = $.upon $.mock stub.object()
    stubMethods = ['get', 'set']
    expect(wrapped[p]).toBeDefined() for p in stubMethods
    expect(typeof wrapped[p]).toBe 'function' for p in stubMethods



  it 'should provide wrapped methods with results', ->

    results = $.upon($.mock stub.object()).get()
    resultMethods = ['thenReturn', 'thenThrow', 'thenCall']
    expect(results[p]).toBeDefined() for p in resultMethods
    expect(typeof results[p]).toBe 'function' for p in resultMethods



  it 'should stub a method to return a value', ->

    mock = $.mock stub.object()
    expectedValue = 'some text'
    $.upon(mock).get().thenReturn expectedValue
    expect(mock.get()).toBe expectedValue



  it 'should stub a method to throw an error', ->

    mock = $.mock stub.object()
    error = new Error 'oops'
    expected = ''
    $.upon(mock).get().thenThrow error
    try mock.get()
    catch e then expected = e
    expect(expected).toBe error



  it 'should stub a method to call a callback', ->

    expectedNumber = 0
    mock = $.mock stub.object()
    callback = -> expectedNumber++
    $.upon(mock).set().thenCall callback
    mock.set()
    expect(expectedNumber).toBe 1