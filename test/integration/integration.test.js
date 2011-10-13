/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , matchers = require('../../lib/matchers')
  , stub = require('../stubs/stub');

var $ = require('../../lib/mock')
  , mock = $.mock
  , when = $.when
  , verify = $.verify
  , any = $.any
  , a = $.a
  , an = $.an
  , matching = $.matching
  , containing = $.containing
  , startingWith = $.startingWith
  , endingWith = $.endingWith;

it['should match a method call with a given value'] = function () {
  
  var mocked = mock(stub.object())
    , givenValue = 'some text';
  
  when(mocked).get(givenValue).thenReturn(true);
  mocked.get(givenValue).should.equal(true);
};

it['should match a method call with a given value of same type'] = function () {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(any('object')).thenReturn(true);
  mocked.get([]).should.equal(true);
};

it['should match a method call with a given value of same class'] = function () {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(a(Date)).thenReturn(true);
  mocked.get(new Date()).should.equal(true);
};

it['should match a method call with a given value matching a regular expression'] = function () {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(matching(/^[a-z0-9-]+$/)).thenReturn(true);
  mocked.get('an-example-of-slug').should.equal(true);
};

it['should match a method call with a given value containing a sub value'] = function () {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(containing('squares')).thenReturn(true);
  mocked.get('circles, squares, triangles').should.equal(true);
};

it['should match a method call with a given value starting with a sub value'] = function () {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(startingWith('circles')).thenReturn(true);
  mocked.get('circles, squares, triangles').should.equal(true);
};

it['should match a method call with a given value ending with a sub value'] = function () {
  
  var mocked = mock(stub.object());
  
  when(mocked).get(endingWith('triangles')).thenReturn(true);
  mocked.get('circles, squares, triangles').should.equal(true);
};

// same scenarios in negation form

it['should not match a method call with a wrong given value'] = function () {
  
  var mocked = mock(stub.object())
    , expected = '';
  
  when(mocked).get(1).thenReturn(true);
  
  try { mocked.get(2); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(1);
};

it['should not match a method call with a given value of wrong type'] = function () {
  
  var mocked = mock(stub.object())
    , expected = '';
  
  when(mocked).get(any('object')).thenReturn(true);
  
  try { mocked.get('a string'); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(any('object').expectedValue());
};

it['should not match a method call with a given value of wrong class'] = function () {
  
  var mocked = mock(stub.object())
    , expected = '';
  
  when(mocked).get(a(Date)).thenReturn(true);
  
  try { mocked.get(42); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(a(Date).expectedValue());
};

it['should not match a method call with a given value not matching a regular expression'] = function () {
  
  var mocked = mock(stub.object())
    , slugRegex = /^[a-z0-9-]+$/
    , expected = '';
  
  when(mocked).get(matching(slugRegex)).thenReturn(true);
  
  try { mocked.get('an invalid slug'); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(matching(slugRegex).expectedValue());
};

it['should not match a method call with a given value not containing a sub value'] = function () {
  
  var mocked = mock(stub.object())
    , subValue = 'squares'
    , expected = '';
  
  when(mocked).get(containing(subValue)).thenReturn(true);
  
  try { mocked.get('only circles and triangles'); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(containing(subValue).expectedValue());
};

it['should not match a method call with a given value not starting with a sub value'] = function () {
  
  var mocked = mock(stub.object())
    , subValue = 'squares'
    , expected = '';
  
  when(mocked).get(startingWith(subValue)).thenReturn(true);
  
  try { mocked.get('circles, squares, triangles'); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(startingWith(subValue).expectedValue());
};

it['should not match a method call with a given value not ending with a sub value'] = function () {
  
  var mocked = mock(stub.object())
    , subValue = 'squares'
    , expected = '';
  
  when(mocked).get(endingWith(subValue)).thenReturn(true);
  
  try { mocked.get('circles, squares, triangles'); }
  catch (e) { expected = e.expected; }
  
  expected.should.be.equal(endingWith(subValue).expectedValue());
};