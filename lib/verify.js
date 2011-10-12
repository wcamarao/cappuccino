/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var should = require('should')
  , state = require('./state');

module.exports = function inject(filter) {
  
  return function verify(mock) {
    
    var verify = filter(mock, wrap);
    
    function wrap(verify, method) {
      return function wrappedMethod () {
        return verifications(method);
      };
    }
    
    function verifications(method) {
      
      function getCount() {
        return state.count(mock, method);
      }
      
      function unless(condition, failureCallback) {
        (!condition) && failureCallback();
      }
      
      function fail(expected) {
        return function() {
          var actual = getCount()
          should.fail(actual, expected, message(method, actual, expected), method+'()');
        };
      }
      
      function message(m, actual, expected) {
        return m+'() should have been called '+expected+', but actually it has been called '+actual+' time(s)';
      }
      
      function handle(callback) {
        return function() {
          var args = arguments
            , expected = 'success';
          
          try { callback.apply(this, args); }
          catch (e) { expected = e; }
          
          return {
            shouldThrow: function(receive) {
              receive(expected);
            }
          };
        }
      }
      
      return verifications = {
        
        allowing: function() {},
        
        never: function() { return this.times(0, 'never'); },
        once:  function() { return this.times(1, 'once');  },
        twice: function() { return this.times(2, 'twice'); },
        
        times: handle(function(n, message) {
          unless(getCount() === n, fail(message || n+' time(s)'));
        }),
        
        atLeast: handle(function(n) {
          unless(getCount() >= n, fail('at least '+n+' time(s)'));
        }),
        
        atMost: handle(function(n) {
          unless(getCount() <= n, fail('at most '+n+' time(s)'));
        }),
        
        between: handle(function(n1, n2) {
          var count = getCount();
          unless(count >= n1 && count <= n2, fail('between '+n1+' and '+n2+' time(s)'));
        }),
        
        only: handle(function() {
          state.methods(mock).forEach(function (m) {
            unless(method === m || state.count(mock, m) === 0, function() {
              var message = m+'() should not be called, since it should call only '+method+'()';
              should.fail('called '+m+'()', 'should not call '+m+'()', message, m+'()');
            });
          });
        })
      };
    }
    
    return verify;
  };
};