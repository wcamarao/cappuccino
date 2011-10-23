#
# mock.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

matchers = module.exports
matchers.Matcher = class Matcher
  constructor: (@value, @mismatches) ->
  expectedValue: -> @value

matchers.identify = (argument) ->
  if argument instanceof Matcher then argument else matchers.equals argument

matchers.equals = (expectedValue) ->
  new Matcher expectedValue, (actualValue) ->
    expectedValue isnt actualValue;

matchers.any = (type) ->
  new Matcher "any #{type}", (actualValue) ->
    typeof actualValue isnt type

instanceOf = (alias) ->
  (Class) ->
    new Matcher alias + Class, (actualValue) ->
      actualValue not instanceof Class

matchers.a = instanceOf 'a '
matchers.an = instanceOf 'an '

matching = (regex, expectedValue) ->
  new Matcher expectedValue, (actualValue) ->
    not actualValue.match regex

matchers.matching = (regex) -> matching regex, "matching #{regex}"
matchers.containing = (value) -> matching new RegExp(value, 'i'), "containing #{value}"
matchers.startingWith = (value) -> matching new RegExp("^#{value}", 'i'), "starting with #{value}"
matchers.endingWith = (value) -> matching new RegExp("#{value}$", 'i'), "ending with #{value}"

matchers.not = (matcher) ->
  new Matcher "not #{matcher.expectedValue()}", (actualValue) ->
    not matcher.mismatches actualValue

expectedValues = (theseMatchers) ->
  values = ''
  values += "#{matcher.expectedValue()}, " for matcher in theseMatchers
  values.replace /,\s$/, ''

matchers.anyOf = (theseMatchers) ->
  new Matcher "any of #{expectedValues(theseMatchers)}", (actualValue) ->
    not(theseMatchers.filter((matcher) ->
      not matcher.mismatches actualValue
    ).length > 0)

matchers.allOf = (theseMatchers) ->
  new Matcher "all of #{expectedValues(theseMatchers)}", (actualValue) ->
    not(theseMatchers.filter((matcher) ->
      not matcher.mismatches actualValue
    ).length is theseMatchers.length)