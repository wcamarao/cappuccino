#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'integration', ->

  stub = require './support/stub'



  it 'should match a method call by a given value', ->

    mocked = mock stub.object()
    givenValue = 'some text'
    upon(mocked).get(givenValue).thenReturn true
    expect(mocked.get givenValue).toBeTruthy()



  it 'should match method calls by given values of same type verifying with allowing and never', ->

    mocked = mock stub.object()
    upon(mocked).get(match.any 'object').thenReturn true
    expect(mocked.get {}).toBeTruthy()
    expect(mocked.get []).toBeTruthy()
    verify(mocked).get().allowing()
    verify(mocked).set().never()



  it 'should match a method call by a given value of same class verifying once', ->

    mocked = mock stub.object()
    upon(mocked).get(match.a Date).thenReturn true
    expect(mocked.get new Date()).toBeTruthy()
    verify(mocked).get().once()



  it 'should match method calls by given values matching a regular expression verifying twice', ->

    mocked = mock stub.object()
    upon(mocked).get(match.matching /^[a-z0-9-]+$/).thenReturn true
    expect(mocked.get 'an-example-of-slug').toBeTruthy()
    expect(mocked.get 'another-example').toBeTruthy()
    verify(mocked).get().twice()



  it 'should match method calls by given values containing a sub value verifying 3 times', ->

    mocked = mock stub.object()
    upon(mocked).get(match.containing 'squares').thenReturn true
    expect(mocked.get 'squares, circles, triangles').toBeTruthy()
    expect(mocked.get 'circles, squares, triangles').toBeTruthy()
    expect(mocked.get 'circles, triangles, squares').toBeTruthy()
    verify(mocked).get().times 3



  it 'should match method calls by given values starting with a sub value verifying with at least', ->

    mocked = mock stub.object()
    upon(mocked).get(match.startingWith 'circles').thenReturn true
    expect(mocked.get 'circles, squares, triangles').toBeTruthy()
    expect(mocked.get 'circles').toBeTruthy()
    verify(mocked).get().atLeast 1
    verify(mocked).get().atLeast 2



  it 'should match method calls by given values ending with a sub value verifying with at most', ->

    mocked = mock stub.object()
    upon(mocked).get(match.endingWith 'triangles').thenReturn true
    expect(mocked.get 'circles, squares, triangles').toBeTruthy()
    expect(mocked.get 'triangles').toBeTruthy()
    verify(mocked).get().atMost 2
    verify(mocked).get().atMost 3



  it 'should match method calls by given values not matching a criteria verifying with between', ->

    mocked = mock stub.object()
    upon(mocked).get(match.not match.containing 'triangles').thenReturn true
    expect(mocked.get 'circles, squares').toBeTruthy()
    expect(mocked.get '').toBeTruthy()
    verify(mocked).get().between t[0], t[1] for t in [ [1,2], [2,2], [2,3] ]



  it 'should match method calls by given values matching any criteria verifying only method called', ->

    mocked = mock stub.object()
    upon(mocked).get(match.anyOf [ match.startingWith('circles'), match.endingWith 'circles' ]).thenReturn true
    expect(mocked.get 'circles, squares').toBeTruthy()
    expect(mocked.get 'triangles, circles').toBeTruthy()
    expect(mocked.get 'circles').toBeTruthy()
    verify(mocked).get().only()



  it 'should match a method call by a given value matching all criteria', ->

    mocked = mock stub.object()
    upon(mocked).get(match.allOf [ match.startingWith('squares'), match.endingWith 'squares' ]).thenReturn true
    expect(mocked.get 'squares').toBeTruthy()



  it 'should not match a method call with a wrongly given value', ->

    mocked = mock stub.object()
    expected = ''
    upon(mocked).get(1).thenReturn true
    try mocked.get 2
    catch e then expected = e.expected
    expect(expected).toBe 1



  it 'should not match a method call with a given value of wrong type', ->

    mocked = mock stub.object()
    expected = ''
    upon(mocked).get(match.any 'object').thenReturn true
    try mocked.get 'a string'
    catch e then expected = e.expected
    expect(expected).toBe match.any('object').expectedValue()



  it 'should not match a method call with a given value of wrong class', ->

    mocked = mock stub.object()
    expected = ''
    upon(mocked).get(match.a Date).thenReturn true
    try mocked.get 42
    catch e then expected = e.expected
    expect(expected).toBe match.a(Date).expectedValue()



  it 'should not match a method call with a given value not matching a regular expression', ->

    mocked = mock stub.object()
    slugRegex = /^[a-z0-9-]+$/
    expected = ''
    upon(mocked).get(match.matching slugRegex).thenReturn true
    try mocked.get 'an invalid slug'
    catch e then expected = e.expected
    expect(expected).toBe match.matching(slugRegex).expectedValue()



  it 'should not match a method call with a given value not containing a sub value', ->

    mocked = mock stub.object()
    subValue = 'squares'
    expected = ''
    upon(mocked).get(match.containing subValue).thenReturn true
    try mocked.get 'only circles and triangles'
    catch e then expected = e.expected
    expect(expected).toBe match.containing(subValue).expectedValue()



  it 'should not match a method call with a given value not starting with a sub value', ->

    mocked = mock stub.object()
    subValue = 'squares'
    expected = ''
    upon(mocked).get(match.startingWith subValue).thenReturn true
    try mocked.get 'circles, squares, triangles'
    catch e then expected = e.expected
    expect(expected).toBe match.startingWith(subValue).expectedValue()



  it 'should not match a method call with a given value not ending with a sub value', ->

    mocked = mock stub.object()
    subValue = 'squares'
    expected = ''
    upon(mocked).get(match.endingWith subValue).thenReturn true
    try mocked.get 'circles, squares, triangles'
    catch e then expected = e.expected
    expect(expected).toBe match.endingWith(subValue).expectedValue()



  it 'should not match method calls by given values failing to not match a criteria', ->

    mocked = mock stub.object()
    expected = ''
    upon(mocked).get(match.not match.containing 'triangles').thenReturn true
    try mocked.get 'circles, triangles, squares'
    catch e then expected = e.expected
    expect(expected).toBe match.not(match.containing 'triangles').expectedValue()



  it 'should not match method calls by given values failing to match any criteria', ->

    mocked = mock stub.object()
    expected = ''
    upon(mocked).get(match.anyOf [ match.startingWith('circles'), match.endingWith 'circles' ]).thenReturn true
    try mocked.get 'triangles, circles, squares'
    catch e then expected = e.expected
    expect(expected).toBe match.anyOf([ match.startingWith('circles'), match.endingWith 'circles' ]).expectedValue()



  it 'should not match method calls by given values failing to match all criteria', ->

    mocked = mock stub.object()
    expected = ''
    upon(mocked).get(match.allOf [ match.startingWith('squares'), match.endingWith 'squares' ]).thenReturn true
    try mocked.get 'squares, triangles'
    catch e then expected = e.expected
    expect(expected).toBe match.allOf([ match.startingWith('squares'), match.endingWith 'squares' ]).expectedValue()