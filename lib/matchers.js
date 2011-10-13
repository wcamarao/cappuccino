/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var matchers = module.exports;

matchers.Matcher = Matcher;

function Matcher(expectedValue, mismatches) {
  this.mismatches = mismatches;
  this.expectedValue = function() {
    return expectedValue;
  };
}

matchers.identify = function(argument) {
  return (argument instanceof Matcher) ? argument : matchers.equals(argument);
};

matchers.equals = function(expectedValue) {
  return new Matcher(expectedValue, function mismatches (actualValue) {
    return expectedValue !== actualValue;
  });
};

matchers.any = function(type) {
  return new Matcher('any ' + type, function(actualValue) {
    return typeof actualValue !== type;
  });
};

matchers.a = instanceOf('a ');
matchers.an = instanceOf('an ');

function instanceOf(label) {
  return function(Class) {
    return new Matcher(label + Class, function mismatches (actualValue) {
      return !(actualValue instanceof Class);
    });
  };
}

matchers.matching = function(regex) {
  return matching(regex, 'matching '+regex);
}

matchers.containing = function(value) {
  return matching(new RegExp(value, 'i'), 'containing '+value);
};

matchers.startingWith = function(value) {
  return matching(new RegExp('^'+value, 'i'), 'starting with '+value);
};

matchers.endingWith = function(value) {
  return matching(new RegExp(value+'$', 'i'), 'ending with '+value);
};

function matching(regex, expectedValue) {
  return new Matcher(expectedValue, function mismatches (actualValue) {
    return !actualValue.match(regex);
  });
}

/*
  not(Matcher)
  anyOf(Matcher, ...)
  allOf(Matcher, ...)
*/
