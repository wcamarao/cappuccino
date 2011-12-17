#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

module.exports = (object, methodCallback, attributeCallback) ->

  e = (arg) -> throw new Error "filter: invalid #{arg} argument"

  e 'object' unless typeof object is 'object'
  e 'methodCallback' unless typeof methodCallback is 'function'
  e 'attributeCallback' unless typeof attributeCallback is 'function' or typeof attributeCallback is 'undefined'

  mock = {}

  for property of object

    if typeof object[property] is 'function'
      mock[property] = methodCallback mock, property

    else if typeof attributeCallback is 'function'
      mock[property] = attributeCallback mock, property

  mock