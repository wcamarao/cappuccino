/*
 * mock.js webapp example
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var api = module.exports;

api.topCategories = function() {
  return ['a real list of top categories from somewhere like a cache or database'];
};

api.topProducts = function() {
  return ['a real list of top products from somewhere like a cache or database'];
}