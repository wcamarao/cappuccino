var match = module.exports;

match.identify = function(argument) {
  return (argument instanceof Matcher) ? argument : match.equals(argument);
};

match.any = function(type) {
  return new Matcher('any ' + type, function(actualValue) {
    return typeof actualValue !== type;
  });
};

match.equals = function(expectedValue) {
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