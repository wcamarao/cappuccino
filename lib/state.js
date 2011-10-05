var state = {};

module.exports.setup = function(mock) {
  state[mock] = {};
}

module.exports.bind = function(mock, method) {
  state[mock][method] = {};
  state[mock][method].matchers = [];
}

module.exports.matcher = function(mock, method, index, matcher) {
  if (matcher) state[mock][method].matchers[index] = matcher;
  return state[mock][method].matchers[index];
}

module.exports.returnValue = function(mock, method, returnValue) {
  if (returnValue) state[mock][method].returnValue = returnValue;
  return state[mock][method].returnValue;
}