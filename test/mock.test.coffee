#
# mock.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

it = module.exports
should = require 'should'
stub = require './stubs/stub'
$ = require '../lib/mock'

it['should mock methods but not other property types'] = ->

  mock = $.mock stub.object()
  methods = ['get', 'set']
  attributes = ['bool', 'number', 'object', 'undef', 'string']
  mock.should.have.property p for p in methods
  mock[p].should.be.a 'function' for p in methods
  mock.should.not.have.property p for p in attributes

it['should default method return values to undefined'] = ->

  mock = $.mock stub.object()
  should.strictEqual mock.get(), undefined
  should.strictEqual mock.set(), undefined

it['should diff original, mock and wrapped methods'] = ->

  original = stub.object()
  mock = $.mock original
  wrapped =
    when: $.when mock
    verify: $.verify mock

  original.get.should.not.equal mock.get
  original.get.should.not.equal wrapped.when.get
  original.get.should.not.equal wrapped.verify.get

  mock.get.should.not.equal wrapped.when.get
  mock.get.should.not.equal wrapped.verify.get

  wrapped.when.get.should.not.equal wrapped.verify.get