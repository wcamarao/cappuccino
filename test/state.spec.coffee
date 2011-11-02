#
# cappuccino
# Copyright c  2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

describe 'state', ->

  state = require '../lib/state'



  it 'should setup an empty state for a mock method', ->

    mock = {}
    method = 'get'
    state.bind mock, method
    expect(state.result mock, method).toBeUndefined()
    expect(state.matcherAt mock, method, 0).toBeUndefined()



  it 'should retrieve methods from a mock', ->

    mock = {}
    firstMethod = 'getSomething'
    secondMethod = 'setSomething'
    state.bind mock, firstMethod
    state.bind mock, secondMethod
    methods = state.methods mock
    expect(methods.length).toBe 2
    expect(methods[0]).toBe firstMethod
    expect(methods[1]).toBe secondMethod



  it 'should set a result for a mock method', ->

    mock = {}
    method = 'get'
    result = 'result'
    state.bind mock, method
    state.setResult mock, method, result
    expect(state.result mock, method).toBe result



  it 'should add matchers for mock method arguments', ->

    mock = {}
    method = 'get'
    firstMatcher = {}
    secondMatcher = []
    state.bind mock, method
    state.addMatcher mock, method, 0, firstMatcher
    state.addMatcher mock, method, 1, secondMatcher
    expect(state.matcherAt mock, method, 0).toBe firstMatcher
    expect(state.matcherAt mock, method, 1).toBe secondMatcher



  it 'should count mock method calls', ->

    mock = {}
    method = 'get'
    state.bind mock, method
    expect(state.count mock, method).toBe 0
    state.increaseCount mock, method
    expect(state.count mock, method).toBe 1