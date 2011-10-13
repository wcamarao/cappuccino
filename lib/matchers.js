/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var matchers = module.exports;

matchers.Matcher = Matcher;

/*
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

matchers.a = instanceOf('a ');
matchers.an = instanceOf('an ');

matchers.equals = function(expectedValue) {
  return new Matcher(expectedValue, function mismatches (actualValue) {
    return expectedValue !== actualValue;
  });
};

function instanceOf(label) {
  return function(Class) {
    return new Matcher(label + Class, function mismatches (actualValue) {
      return !(actualValue instanceof Class);
    });
  };
}

function Matcher(expectedValue, mismatches) {
  this.mismatches = mismatches;
  this.expectedValue = function() {
    return expectedValue;
  };
}