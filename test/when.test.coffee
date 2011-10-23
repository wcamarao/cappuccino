#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../lib/cappuccino').inject module.exports
stub = require './stubs/stub'

$.it 'should wrap methods in when(mock) context', ->

  wrapped = $.when $.mock stub.object()
  stubMethods = ['get', 'set']
  wrapped.should.have.property p for p in stubMethods
  wrapped[p].should.be.a 'function' for p in stubMethods

$.it 'should provide wrapped methods with results', ->

  results = $.when($.mock stub.object()).get()
  resultMethods = ['thenReturn', 'thenThrow', 'thenCall']
  results.should.have.property p for p in resultMethods
  results[p].should.be.a 'function' for p in resultMethods

$.it 'should stub a method to return a value', ->

  mock = $.mock stub.object()
  expectedValue = 'some text'
  $.when(mock).get().thenReturn expectedValue
  mock.get().should.equal expectedValue

$.it 'should stub a method to throw an error', ->

  mock = $.mock stub.object()
  error = new Error 'oops'
  expected = ''
  $.when(mock).get().thenThrow error
  try mock.get()
  catch e
    expected = e
  expected.should.be.equal error

$.it 'should stub a method to call a callback', ->

  expectedNumber = 0
  mock = $.mock stub.object()
  callback = -> expectedNumber++
  $.when(mock).set().thenCall callback
  mock.set()
  expectedNumber.should.equal 1