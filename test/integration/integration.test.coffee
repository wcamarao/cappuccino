#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../../lib/cappuccino').inject module.exports
stub = require '../stubs/stub'

$.it 'should match a method call by a given value', ->

  mocked = $.mock stub.object()
  givenValue = 'some text'
  $.when(mocked).get(givenValue).thenReturn true
  mocked.get(givenValue).should.equal true

$.it 'should match method calls by given values of same type verifying with allowing and never', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.any 'object').thenReturn true
  mocked.get({}).should.equal true
  mocked.get([]).should.equal true
  $.verify(mocked).get().allowing()
  $.verify(mocked).set().never()

$.it 'should match a method call by a given value of same class verifying once', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.a Date).thenReturn true
  mocked.get(new Date()).should.equal true
  $.verify(mocked).get().once()

$.it 'should match method calls by given values matching a regular expression verifying twice', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.matching /^[a-z0-9-]+$/).thenReturn true
  mocked.get('an-example-of-slug').should.equal true
  mocked.get('another-example').should.equal true
  $.verify(mocked).get().twice()

$.it 'should match method calls by given values containing a sub value verifying 3 times', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.containing 'squares').thenReturn true
  mocked.get('squares, circles, triangles').should.equal true
  mocked.get('circles, squares, triangles').should.equal true
  mocked.get('circles, triangles, squares').should.equal true
  $.verify(mocked).get().times 3

$.it 'should match method calls by given values starting with a sub value verifying with at least', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.startingWith 'circles').thenReturn true
  mocked.get('circles, squares, triangles').should.equal true
  mocked.get('circles').should.equal true
  $.verify(mocked).get().atLeast 1
  $.verify(mocked).get().atLeast 2

$.it 'should match method calls by given values ending with a sub value verifying with at most', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.endingWith 'triangles').thenReturn true
  mocked.get('circles, squares, triangles').should.equal true
  mocked.get('triangles').should.equal true
  $.verify(mocked).get().atMost 2
  $.verify(mocked).get().atMost 3

$.it 'should match method calls by given values not matching a criteria verifying with between', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.not $.containing 'triangles').thenReturn true
  mocked.get('circles, squares').should.equal true
  mocked.get('').should.equal true
  $.verify(mocked).get().between t[0], t[1] for t in [ [1,2], [2,2], [2,3] ]

$.it 'should match method calls by given values matching any criteria verifying only method called', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.anyOf [ $.startingWith('circles'), $.endingWith 'circles' ]).thenReturn true
  mocked.get('circles, squares').should.equal true
  mocked.get('triangles, circles').should.equal true
  mocked.get('circles').should.equal true
  $.verify(mocked).get().only()

$.it 'should match a method call by a given value matching all criteria', ->

  mocked = $.mock stub.object()
  $.when(mocked).get($.allOf [ $.startingWith('squares'), $.endingWith 'squares' ]).thenReturn true
  mocked.get('squares').should.equal true

$.it 'should not match a method call with a wrongly given value', ->

  mocked = $.mock stub.object()
  expected = ''
  $.when(mocked).get(1).thenReturn true
  try mocked.get 2
  catch e then expected = e.expected
  expected.should.be.equal 1

$.it 'should not match a method call with a given value of wrong type', ->

  mocked = $.mock stub.object()
  expected = ''
  $.when(mocked).get($.any 'object').thenReturn true
  try mocked.get 'a string'
  catch e then expected = e.expected
  expected.should.be.equal $.any('object').expectedValue()

$.it 'should not match a method call with a given value of wrong class', ->

  mocked = $.mock stub.object()
  expected = ''
  $.when(mocked).get($.a Date).thenReturn true
  try mocked.get 42
  catch e then expected = e.expected
  expected.should.be.equal $.a(Date).expectedValue()

$.it 'should not match a method call with a given value not matching a regular expression', ->

  mocked = $.mock stub.object()
  slugRegex = /^[a-z0-9-]+$/
  expected = ''
  $.when(mocked).get($.matching slugRegex).thenReturn true
  try mocked.get 'an invalid slug'
  catch e then expected = e.expected
  expected.should.be.equal $.matching(slugRegex).expectedValue()

$.it 'should not match a method call with a given value not containing a sub value', ->

  mocked = $.mock stub.object()
  subValue = 'squares'
  expected = ''
  $.when(mocked).get($.containing subValue).thenReturn true
  try mocked.get 'only circles and triangles'
  catch e then expected = e.expected
  expected.should.be.equal $.containing(subValue).expectedValue()

$.it 'should not match a method call with a given value not starting with a sub value', ->

  mocked = $.mock stub.object()
  subValue = 'squares'
  expected = ''
  $.when(mocked).get($.startingWith subValue).thenReturn true
  try mocked.get 'circles, squares, triangles'
  catch e then expected = e.expected
  expected.should.be.equal $.startingWith(subValue).expectedValue()

$.it 'should not match a method call with a given value not ending with a sub value', ->

  mocked = $.mock stub.object()
  subValue = 'squares'
  expected = ''
  $.when(mocked).get($.endingWith subValue).thenReturn true
  try mocked.get 'circles, squares, triangles'
  catch e then expected = e.expected
  expected.should.be.equal $.endingWith(subValue).expectedValue()

$.it 'should not match method calls by given values failing to not match a criteria', ->

  mocked = $.mock stub.object()
  expected = ''
  $.when(mocked).get($.not $.containing 'triangles').thenReturn true
  try mocked.get('circles, triangles, squares').should.equal true
  catch e then expected = e.expected
  expected.should.be.equal $.not($.containing 'triangles').expectedValue()

$.it 'should not match method calls by given values failing to match any criteria', ->

  mocked = $.mock stub.object()
  expected = ''
  $.when(mocked).get($.anyOf [ $.startingWith('circles'), $.endingWith 'circles' ]).thenReturn true
  try mocked.get('triangles, circles, squares').should.equal true
  catch e then expected = e.expected
  expected.should.be.equal $.anyOf([ $.startingWith('circles'), $.endingWith 'circles' ]).expectedValue()

$.it 'should not match method calls by given values failing to match all criteria', ->

  mocked = $.mock stub.object()
  expected = ''
  $.when(mocked).get($.allOf [ $.startingWith('squares'), $.endingWith 'squares' ]).thenReturn true
  try mocked.get('squares, triangles').should.equal true
  catch e then expected = e.expected
  expected.should.be.equal $.allOf([ $.startingWith('squares'), $.endingWith 'squares' ]).expectedValue()