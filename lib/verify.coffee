#
# cappuccino
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

assert = require 'assert'
filter = require './filter'
state = require './state'

module.exports = (mock) ->

  wrap = (verify, method) ->
    wrappedMethod = () ->
      verifications method

  verifications = (method) ->

    getCount = () ->
      state.count mock, method

    fail = (expected) ->
      actual = getCount()
      assert.fail actual, expected, message(method, actual, expected), "#{method}()"

    message = (method, actual, expected) ->
      "#{method}() should have been called #{expected}, but actually it has been called #{actual} time(s)"

    verifications =

      allowing: () ->

      never: () -> @times 0, 'never'
      once:  () -> @times 1, 'once'
      twice: () -> @times 2, 'twice'

      times: (n, message) ->
        fail message or n+' time(s)' unless getCount() is n

      atLeast: (n) ->
        fail "at least #{n} time(s)" unless getCount() >= n

      atMost: (n) ->
        fail "at most #{n} time(s)" unless getCount() <= n

      between: (n1, n2) ->
        count = getCount()
        fail "between #{n1} and #{n2} time(s)" unless count >= n1 and count <= n2

      only: () ->
        state.methods(mock).forEach (m) ->
          if method isnt m and state.count(mock, m) isnt 0
            message = "#{m}() should not be called, since it should call only #{method}()"
            assert.fail("called #{m}()", "should not call #{m}()", message, "#{m}()");

  filter mock, wrap