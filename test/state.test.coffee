#
# cappuccino
# Copyright c  2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../lib/cappuccino').inject module.exports
should = require 'should'
state = require '../lib/state'

$.it 'should setup an empty state for a mock method', ->

  mock = {}
  method = 'get'
  state.bind mock, method
  should.not.exist state.result mock, method
  should.not.exist state.matcherAt mock, method, 0

$.it 'should retrieve methods from a mock', ->

  mock = {}
  firstMethod = 'getSomething'
  secondMethod = 'setSomething'
  state.bind mock, firstMethod
  state.bind mock, secondMethod
  methods = state.methods mock
  methods.length.should.equal 2
  methods[0].should.equal firstMethod
  methods[1].should.equal secondMethod

$.it 'should set a result for a mock method', ->

  mock = {}
  method = 'get'
  result = 'result'
  state.bind mock, method
  state.setResult mock, method, result
  state.result(mock, method).should.equal result

$.it 'should add matchers for mock method arguments', ->

  mock = {}
  method = 'get'
  firstMatcher = {}
  secondMatcher = []
  state.bind mock, method
  state.addMatcher mock, method, 0, firstMatcher
  state.addMatcher mock, method, 1, secondMatcher
  state.matcherAt(mock, method, 0).should.equal firstMatcher
  state.matcherAt(mock, method, 1).should.equal secondMatcher

$.it 'should count mock method calls', ->

  mock = {}
  method = 'get'
  state.bind mock, method
  state.count(mock, method).should.equal 0
  state.increaseCount mock, method
  state.count(mock, method).should.equal 1