#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../lib/cappuccino').inject module.exports
stub = require './stubs/stub'

$.it 'should wrap methods in $.verify(mock) context', ->

  wrapped = $.verify $.mock stub.object()
  wrapped.should.have.property 'get'
  wrapped['get'].should.be.a 'function'

$.it 'should provide wrapped methods with verifications', ->

  verifications = $.verify($.mock stub.object()).get()
  methods = [ 'allowing', 'never', 'once', 'twice', 'times', 'atLeast', 'atMost', 'between', 'only' ]
  verifications.should.have.property p for p in methods
  verifications[p].should.be.a 'function' for p in methods

$.it 'should verify that a method is always allowed to be called', ->

  mocked = $.mock stub.object()
  mocked.get() for n in [1..5]
  $.verify(mocked).get().allowing()

$.it 'should default to verify that a method is always allowed to be called', ->

  mocked = $.mock stub.object()
  mocked.get() for n in [1..5]

$.it 'should verify that a method has never been called', ->

  mocked = $.mock stub.object()
  mocked.get()
  $.verify(mocked).set().never()

$.it 'should verify that a method has been called once', ->

  mocked = $.mock stub.object()
  mocked.get()
  $.verify(mocked).get().once()

$.it 'should verify that a method has been called twice', ->

  mocked = $.mock stub.object()
  mocked.get() for n in [1..2]
  $.verify(mocked).get().twice()

$.it 'should verify that a method has been called n times', ->

  mocked = $.mock stub.object()
  mocked.set() for n in [1..3]
  $.verify(mocked).set().times 3

$.it 'should verify that a method has been called at least n times', ->

  mocked = $.mock stub.object()
  mocked.get() for n in [1..3]
  $.verify(mocked).get().atLeast n for n in [0..3]

$.it 'should verify that a method has been called at most n times', ->

  mocked = $.mock stub.object()
  mocked.get() for n in [1..3]
  $.verify(mocked).get().atMost n for n in [3..5]

$.it 'should verify that a method has been called between n1 and n2 times', ->

  mocked = $.mock stub.object()
  mocked.get() for n in [1..2]
  $.verify(mocked).get().between t[0], t[1] for t in [ [0,2], [0,3], [1,2], [1,3], [2,2] ]

$.it 'should verify that a method has been the only one called', ->

  mocked = $.mock stub.object()
  mocked.get()
  $.verify(mocked).get().only()

$.it 'should fail verifying that a method has never been called', ->

  mocked = $.mock stub.object()
  expected = ''
  mocked.get()
  try $.verify(mocked).get().never()
  catch e
    expected = e.expected
  expected.should.be.equal 'never'

$.it 'should fail verifying that a method has been called once', ->

  mocked = $.mock stub.object()
  expected = ''
  try $.verify(mocked).get().once()
  catch e
    expected = e.expected
  expected.should.be.equal 'once'

$.it 'should fail verifying that a method has been called twice', ->

  mocked = $.mock stub.object()
  expected = ''
  mocked.get()
  try $.verify(mocked).get().twice()
  catch e
    expected = e.expected
  expected.should.be.equal 'twice'

$.it 'should fail verifying that a method has been called n times', ->

  mocked = $.mock stub.object()
  expected = ''
  mocked.get() for n in [1..2]
  try $.verify(mocked).get().times 3
  catch e
    expected = e.expected
  expected.should.be.equal '3 time(s)'

$.it 'should fail verifying that a method has been called at least n times', ->

  mocked = $.mock stub.object()
  expected = ''
  mocked.get()
  try $.verify(mocked).get().atLeast 2
  catch e
    expected = e.expected
  expected.should.be.equal 'at least 2 time(s)'

$.it 'should fail verifying that a method has been called at most n times', ->

  mocked = $.mock stub.object()
  expected = ''
  mocked.get() for n in [1..2]
  try $.verify(mocked).get().atMost 1
  catch e
    expected = e.expected
  expected.should.be.equal 'at most 1 time(s)'

$.it 'should fail verifying that a method has been called between n1 and n2 times', ->

  mocked = $.mock stub.object()

  expected = ''
  mocked.get() for n in [1..2]
  try $.verify(mocked).get().between 0, 1
  catch e
    expected = e.expected
  expected.should.be.equal 'between 0 and 1 time(s)'

  expected = ''
  try $.verify(mocked).get().between 3, 3
  catch e
    expected = e.expected
  expected.should.be.equal 'between 3 and 3 time(s)'

$.it 'should fail verifying that a method has been the only one called', ->

  mocked = $.mock stub.object()
  expected = ''
  mocked.get()
  try $.verify(mocked).set().only()
  catch e
    expected = e.expected
  expected.should.be.equal 'should not call get()'