#
# mock.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = (object, functionCallback, attributeCallback) ->
  mock = {}
  for property of object
    if typeof object[property] is 'function'
      mock[property] = functionCallback mock, property
    else if typeof attributeCallback is 'function'
      mock[property] = attributeCallback mock, property
  mock