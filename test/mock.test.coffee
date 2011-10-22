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

  mock.should.have.property 'get'
  mock.should.have.property 'set'

  mock['get'].should.be.a 'function'
  mock['set'].should.be.a 'function'

  mock.should.not.have.property 'bool'
  mock.should.not.have.property 'number'
  mock.should.not.have.property 'object'
  mock.should.not.have.property 'undef'
  mock.should.not.have.property 'string'

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