#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = (object, functionCallback, attributeCallback) ->

  err = (message) ->
    throw new Error "filter: invalid #{message}"

  err 'object' unless typeof object is 'object'
  err 'functionCallback' unless typeof functionCallback is 'function'
  err 'attributeCallback' unless typeof attributeCallback is 'undefined' or typeof attributeCallback is 'function'

  mock = {}

  for property of object

    if typeof object[property] is 'function'
      mock[property] = functionCallback mock, property

    else if typeof attributeCallback is 'function'
      mock[property] = attributeCallback mock, property

  mock