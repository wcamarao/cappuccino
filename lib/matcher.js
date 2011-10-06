var matcher = module.exports;

matcher.identify = function(argument) {
  return (argument instanceof Matcher) ? argument : matcher.equals(argument);
};

matcher.any = function(type) {
  return create('any ' + type, function(actualValue) {
    return typeof actualValue !== type;
  });
};

matcher.equals = function(expectedValue) {
  return create(expectedValue, function(actualValue) {
    return expectedValue !== actualValue;
  });
};

function create(expectedValue, mismatches) {
  return new Matcher(mismatches, function() {
    return expectedValue;
  });
}

function Matcher(mismatches, expectedValue) {
  this.mismatches = mismatches;
  this.expectedValue = expectedValue;
}