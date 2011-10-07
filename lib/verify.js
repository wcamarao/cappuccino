/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

module.exports = function inject(filter) {
  
  return function verify(mock) {
    
    var wrapper = {};
    filter(mock, wrapper, wrap);
    
    function wrap(method) {
      return function wrappedMethod() {
        return verifications(method);
      };
    }
    
    function verifications(method) {
      return {
        /*
          once()
          twice()
          times(x)
          atLeast(x)
          atMost(x)
          between(x,y)
          allowing()
          ignoring()
          never()
          only()
        */
      };
    }
    
    return wrapper;
  };
};