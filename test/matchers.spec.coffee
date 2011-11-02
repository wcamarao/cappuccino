#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require '../lib/mock'
matchers = require '../lib/matchers'

describe 'matchers', ->



  it 'should handle non-matcher values using default equals matcher', ->

    argument = 'any non-matcher value'
    matcher = matchers.identify argument
    expect(matcher instanceof matchers.Matcher).toBeTruthy()
    expect(matcher.expectedValue()).toBe argument
    expect(matcher).not.toBe argument



  it 'should identify matcher values and return themselves', ->

    argument = $.any 'object'
    matcher = matchers.identify argument
    expect(matcher instanceof matchers.Matcher).toBeTruthy()
    expect(matcher.expectedValue()).not.toBe argument
    expect(matcher).toBe argument



  it 'should match equals values', ->

    givenValue = 'some text'
    otherValue = 'something else'
    matcher = matchers.identify givenValue
    expect(matcher.mismatches otherValue).toBeTruthy()
    expect(matcher.mismatches givenValue).toBeFalsy()



  it 'should match values by same type', ->

    anObject = {}
    aNumber = 42
    matcher = matchers.identify $.any 'object'
    expect(matcher.mismatches aNumber).toBeTruthy()
    expect(matcher.mismatches anObject).toBeFalsy()



  it 'should match values by same class', ->

    aDate = new Date()
    aNumber = 42
    matcherA = matchers.identify $.a Date
    matcherAn = matchers.identify $.an Date
    expect(matcherA.mismatches aNumber).toBeTruthy()
    expect(matcherA.mismatches aDate).toBeFalsy()
    expect(matcherAn.mismatches aNumber).toBeTruthy()
    expect(matcherAn.mismatches aDate).toBeFalsy()



  it 'should match values by regular expressions', ->

    aSlug = 'this-is-a-slug'
    anInvalidSlug = 'but not this'
    matcher = matchers.identify $.matching /^[a-z0-9-]+$/
    expect(matcher.mismatches anInvalidSlug).toBeTruthy()
    expect(matcher.mismatches aSlug).toBeFalsy()



  it 'should match values by containing a sub value', ->

    aText = 'it could be a huge text containing dates and reviews'
    anotherText = 'and another one containing only reviews'
    matcher = matchers.identify $.containing 'dates'
    expect(matcher.mismatches anotherText).toBeTruthy()
    expect(matcher.mismatches aText).toBeFalsy()



  it 'should match values by starting with a sub value', ->

    aText = 'it could be a huge text containing dates and reviews'
    anotherText = 'and another one containing only reviews'
    matcher = matchers.identify $.startingWith 'it could be'
    expect(matcher.mismatches anotherText).toBeTruthy()
    expect(matcher.mismatches aText).toBeFalsy()



  it 'should match values by ending with a sub value', ->

    aText = 'it could be a huge text containing dates and reviews'
    anotherText = 'and another one containing only reviews'
    matcher = matchers.identify $.endingWith 'and reviews'
    expect(matcher.mismatches anotherText).toBeTruthy()
    expect(matcher.mismatches aText).toBeFalsy()



  it 'should match values by negating a matcher', ->

    aText = 'it could be a huge text containing dates and reviews'
    anotherText = 'and another one containing only reviews'
    matcher = matchers.identify $.not $.containing 'dates'
    expect(matcher.mismatches aText).toBeTruthy()
    expect(matcher.mismatches anotherText).toBeFalsy()



  it 'should match values by satisfying any matcher', ->

    aText = 'it could be a text containing dates'
    anotherText = 'and another one containing reviews'
    matcher = matchers.identify $.anyOf [ $.containing('dates'), $.containing 'reviews' ]
    expect(matcher.mismatches aText).toBeFalsy()
    expect(matcher.mismatches anotherText).toBeFalsy()



  it 'should match values by satisfying all matchers', ->

    aText = 'it could be a huge text containing dates'
    anotherText = 'and a smaller text containing dates'
    matcher = matchers.identify $.allOf [ $.containing('text'), $.endingWith 'dates' ]
    expect(matcher.mismatches aText).toBeFalsy()
    expect(matcher.mismatches anotherText).toBeFalsy()