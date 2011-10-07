/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var matchers = module.exports;

/*
  a(Class)
  an(Class)
  
  matches(regex)
  contains(s)
  startsWith(s)
  endsWith(s)
  
  not(Matcher)
  anyOf(Matcher, ...)
  allOf(Matcher, ...)
*/

matchers.identify = function(argument) {
  return (argument instanceof Matcher) ? argument : matchers.equals(argument);
};

matchers.any = function(type) {
  return new Matcher('any ' + type, function(actualValue) {
    return typeof actualValue !== type;
  });
};

matchers.equals = function(expectedValue) {
  return new Matcher(expectedValue, function(actualValue) {
    return expectedValue !== actualValue;
  });
};

function Matcher(expectedValue, mismatches) {
  this.mismatches = mismatches;
  this.expectedValue = function() {
    return expectedValue;
  };
}