#
# mock.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

stub = module.exports

stub.object = ->
  bool: true
  number: 1
  object: []
  undef: undefined
  string: 'some text'
  get: -> 0
  set: (key, value) -> @object[key] = value