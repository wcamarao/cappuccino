/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , should = require('should')
  , matchers = require('../lib/matchers')
  , any = require('../lib/mock').any;

it['should identify non-matcher values and wrap them by default with equals matcher'] = function() {
  
  var argument = 'any non-matcher value'
    , matcher = matchers.identify(argument)
  
  matcher.should.be.an.instanceof(matchers.Matcher);
  matcher.expectedValue().should.be.equal(argument);
  matcher.should.not.be.equal(argument);
};

it['should identify matcher values and return themselves'] = function() {
  
  var argument = any('object')
    , matcher = matchers.identify(argument)
  
  matcher.should.be.an.instanceof(matchers.Matcher);
  matcher.expectedValue().should.not.be.equal(argument);
  matcher.should.be.equal(argument);
};

it['should match equals values'] = function() {
  
  var givenValue = 'some text'
    , otherValue = 'something else'
    , matcher = matchers.identify(givenValue);
  
  matcher.mismatches(otherValue).should.be.true;
  matcher.mismatches(givenValue).should.not.be.true;
};

it['should match values by same type'] = function() {
  
  var anObject = {}
    , aNumber = 42
    , matcher = matchers.identify(any('object'));
  
  matcher.mismatches(aNumber).should.be.true;
  matcher.mismatches(anObject).should.not.be.true;
};