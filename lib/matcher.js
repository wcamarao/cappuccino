var matcher = module.exports;

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
  return {
    mismatches: mismatches,
    value: function() {
      return expectedValue;
    }
  };
}