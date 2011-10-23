#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../lib/cappuccino').inject module.exports
matchers = require '../lib/matchers'

$.it 'should identify non-matcher values and wrap them by default with equals matcher', ->

  argument = 'any non-matcher value'
  matcher = matchers.identify argument
  matcher.should.be.an.instanceof matchers.Matcher
  matcher.expectedValue().should.be.equal argument
  matcher.should.not.be.equal argument

$.it 'should identify matcher values and return themselves', ->

  argument = $.any 'object'
  matcher = matchers.identify argument
  matcher.should.be.an.instanceof matchers.Matcher
  matcher.expectedValue().should.not.be.equal argument
  matcher.should.be.equal argument

$.it 'should match equals values', ->

  givenValue = 'some text'
  otherValue = 'something else'
  matcher = matchers.identify givenValue
  matcher.mismatches(otherValue).should.be.true
  matcher.mismatches(givenValue).should.not.be.true

$.it 'should match values by same type', ->

  anObject = {}
  aNumber = 42
  matcher = matchers.identify $.any 'object'
  matcher.mismatches(aNumber).should.be.true
  matcher.mismatches(anObject).should.not.be.true

$.it 'should match values by same class', ->

  aDate = new Date()
  aNumber = 42
  matcherA = matchers.identify $.a Date
  matcherAn = matchers.identify $.an Date
  matcherA.mismatches(aNumber).should.be.true
  matcherA.mismatches(aDate).should.not.be.true
  matcherAn.mismatches(aNumber).should.be.true
  matcherAn.mismatches(aDate).should.not.be.true

$.it 'should match values by regular expressions', ->

  aSlug = 'this-is-a-slug'
  anInvalidSlug = 'but not this'
  matcher = matchers.identify $.matching /^[a-z0-9-]+$/
  matcher.mismatches(anInvalidSlug).should.be.true
  matcher.mismatches(aSlug).should.not.be.true

$.it 'should match values by containing a sub value', ->

  aText = 'it could be a huge text containing dates and reviews'
  anotherText = 'and another one containing only reviews'
  matcher = matchers.identify $.containing 'dates'
  matcher.mismatches(anotherText).should.be.true
  matcher.mismatches(aText).should.not.be.true

$.it 'should match values by starting with a sub value', ->

  aText = 'it could be a huge text containing dates and reviews'
  anotherText = 'and another one containing only reviews'
  matcher = matchers.identify $.startingWith 'it could be'
  matcher.mismatches(anotherText).should.be.true
  matcher.mismatches(aText).should.not.be.true

$.it 'should match values by ending with a sub value', ->

  aText = 'it could be a huge text containing dates and reviews'
  anotherText = 'and another one containing only reviews'
  matcher = matchers.identify $.endingWith 'and reviews'
  matcher.mismatches(anotherText).should.be.true
  matcher.mismatches(aText).should.not.be.true

$.it 'should match values by negating a matcher', ->

  aText = 'it could be a huge text containing dates and reviews'
  anotherText = 'and another one containing only reviews'
  matcher = matchers.identify $.not $.containing 'dates'
  matcher.mismatches(aText).should.be.true
  matcher.mismatches(anotherText).should.not.be.true

$.it 'should match values by satisfying any matcher', ->

  aText = 'it could be a text containing dates'
  anotherText = 'and another one containing reviews'
  matcher = matchers.identify $.anyOf [ $.containing('dates'), $.containing 'reviews' ]
  matcher.mismatches(aText).should.be.false
  matcher.mismatches(anotherText).should.be.false

$.it 'should match values by satisfying all matchers', ->

  aText = 'it could be a huge text containing dates'
  anotherText = 'and a smaller text containing dates'
  matcher = matchers.identify $.allOf [ $.containing('text'), $.endingWith 'dates' ]
  matcher.mismatches(aText).should.be.false
  matcher.mismatches(anotherText).should.be.false