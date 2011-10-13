/*
 * mock.js webapp example
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var api = module.exports
  , persistence = require('./persistence');

api.inject = function(injectedPersistence) {
  persistence = injectedPersistence;
};

api.index = function(req, res) {
  res.render('index', { topCategories: persistence.topCategories(), topProducts: persistence.topProducts() });
}