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