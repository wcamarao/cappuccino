/*
 * mock.js webapp example
 * Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
 * MIT Licensed
 */

var it = module.exports
  , controller = require('./controller')
  , originalPersistence = require('./persistence');

var $ = require('../../lib/mock.js')
  , mock = $.mock
  , when = $.when
  , verify = $.verify;

it['should retrieve top categories and top products from persistence when rendering index page'] = function () {
  
  var mockedPersistence = mock(originalPersistence)
    , expectedTopCategories = ['mocked list of top categories']
    , expectedTopProducts = ['mocked list of top products']
    , actualTopCategories = ''
    , actualTopProducts = '';
  
  controller.inject(mockedPersistence);
  
  when(mockedPersistence).topCategories().thenReturn(expectedTopCategories);
  when(mockedPersistence).topProducts().thenReturn(expectedTopProducts);
  
  controller.index({}, {
    render: function (page, data) {
      actualTopCategories = data.topCategories;
      actualTopProducts = data.topProducts;
    }
  });
  
  expectedTopCategories.should.be.equal(actualTopCategories);
  expectedTopProducts.should.be.equal(actualTopProducts);
  
  verify(mockedPersistence).topCategories().once();
  verify(mockedPersistence).topProducts().once();
};