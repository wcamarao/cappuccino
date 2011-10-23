#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ = require('../lib/cappuccino').inject module.exports
count = 0
reNew = 0

$.before ->
  count++
  reNew = 1

$.it 'should execute a code block before each test', ->

  count.should.be.equal 1
  reNew.should.be.equal 1

  count = 10
  reNew = 10

$.it 'should keep shared state from previous tests', ->

  count.should.be.equal 11
  reNew.should.be.equal 1