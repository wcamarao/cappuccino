var api = module.exports
  , state = {};

api.setup = function(mock) {
  state[mock] = {};
}

api.bind = function(mock, method) {
  state[mock][method] = {};
  state[mock][method].matchers = [];
}

api.addMatcher = function(mock, method, index, matcher) {
  state[mock][method].matchers[index] = matcher;
}

api.matcherAt = function(mock, method, index) {
  return state[mock][method].matchers[index];
}

api.setResult = function(mock, method, result) {
  state[mock][method].result = result;
}

api.result = function(mock, method) {
  return state[mock][method].result;
}