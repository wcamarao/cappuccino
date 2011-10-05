var matcher = module.exports;

matcher.equals = function(expectedValue) {
  return {
    mismatches: function(actualValue) {
      return actualValue !== expectedValue;
    },
    value: function() {
      return expectedValue;
    }
  };
}