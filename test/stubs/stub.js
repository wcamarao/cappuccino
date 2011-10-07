/*
 * mock.js
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var stub = module.exports;

stub.object = function() {
  return {
    bool: true,
    number: 1,
    object: [],
    undef: undefined,
    string: 'some text',
    get: function() { return 0; }
  };
};