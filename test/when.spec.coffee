#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require '../lib/mock'
stub = require './stubs/stub'

describe 'when', ->



  it 'should wrap methods in when(mock) context', ->

    wrapped = $.when $.mock stub.object()
    stubMethods = ['get', 'set']
    expect(wrapped[p]).toBeDefined() for p in stubMethods
    expect(typeof wrapped[p]).toBe 'function' for p in stubMethods



  it 'should provide wrapped methods with results', ->

    results = $.when($.mock stub.object()).get()
    resultMethods = ['thenReturn', 'thenThrow', 'thenCall']
    expect(results[p]).toBeDefined() for p in resultMethods
    expect(typeof results[p]).toBe 'function' for p in resultMethods



  it 'should stub a method to return a value', ->

    mock = $.mock stub.object()
    expectedValue = 'some text'
    $.when(mock).get().thenReturn expectedValue
    expect(mock.get()).toBe expectedValue



  it 'should stub a method to throw an error', ->

    mock = $.mock stub.object()
    error = new Error 'oops'
    expected = ''
    $.when(mock).get().thenThrow error
    try mock.get()
    catch e then expected = e
    expect(expected).toBe error



  it 'should stub a method to call a callback', ->

    expectedNumber = 0
    mock = $.mock stub.object()
    callback = -> expectedNumber++
    $.when(mock).set().thenCall callback
    mock.set()
    expect(expectedNumber).toBe 1