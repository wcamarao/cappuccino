# cappuccino

### hot mocking library for node.js

  It puts together expresso, should and a self-contained mocking library, which API is similar to Mockito, but with some different aspects. It's a bit more lax, as it allows method calls in mocks by default. There are more differences that you may find out by giving it a try.

## Installation

Using the node package manager

    $ npm install cappuccino

## Quick Start

### Given the following User class

    function User(name) {
      this.name = name;
      this.toString = function() {
        return "User name: " + this.name;
      };
      this.meet = function(someone) {
        return "Nice to meet you " + someone;
      };
    }

### Import cappuccino

    var $ = require('cappuccino');

### Write your tests like

    $.before(function () {
      // this block is executed before each test
    });

    $.it('should behave like', function () {
      // your test code here
    });

### Mock an existent object

    var user = new User('functioncallback');
    var mockedUser = $.mock(user);

### Stub a method to return a value

    $.when(mockedUser).toString().thenReturn('Mocked user name');

    user.toString();       // returns "User name: functioncallback"
    mockedUser.toString(); // returns "Mocked user name"

### Verify that a method has called twice

    mockedUser.toString();
    mockedUser.toString();

    $.verify(mockedUser).toString().twice();

### Match a method call by argument value

    $.when(mockedUser).meet('foo').thenReturn('Hi foo'); // here, meet('foo') defaults to match equals('foo')

    mockedUser.meet('foo'); // returns "Hi foo"
    mockedUser.meet('bar'); // fails, as it doesn't match equals('foo')

### Match a method call by argument type

    $.when(mockedUser).meet($.any('number')).thenReturn('Hello, numberic value'); // now it will match any number

    mockedUser.meet(123); // returns "Hello, numeric value"
    mockedUser.meet('s'); // fails, as it's not a number

## API

### Functions that you can import

    var $ = require('cappuccino')

      , it = $.it
      , before = $.before
      , mock = $.mock
      , when = $.when
      , verify = $.verify

      , any = $.any
      , a = $.a
      , an = $.an
      , matching = $.matching
      , containing = $.containing
      , startingWith = $.startingWith
      , endingWith = $.endingWith
      , not = $.not
      , anyOf = $.anyOf
      , allOf = $.allOf;

### Primary functions

    it(statement, callback)
    before(callback)
    mock(object)
    when(mockedObject)
    verify(mockedObject)

### Built-in matchers

  These functions strict a mock method to be called with arguments according to specific conditions

  Non-matcher values default to equals(value)

    any(type)
    a(Class)
    an(Class)
    matching(regex)
    containing(value)
    startingWith(value)
    endingWith(value)
    not(matcher)
    anyOf([matcher, ...])
    allOf([matcher, ...])

## Functions within contexts

### when(mockedObject).doesSomething()

  These functions state how a mock method should behave

  It defaults to return void/undefined

    thenReturn(value)
    thenThrow(error)
    thenCall(callback)

### verify(mockedObject).hasDoneSomething()

  These functions verify that a mock method has been called a specific number of times

  It defaults to allow the function to be called Infinity times

    never()
    once()
    twice()
    times(n)
    atLeast(n)
    atMost(n)
    between(n1, n2)
    only()

## Running Tests

  First, [download source](https://github.com/functioncallback/cappuccino/tarball/master) and install dependencies with npm

    $ npm install

  Then

    $ make test

## Future directions

  Verification in order<br>
  API to extend matchers<br>
  Spy objects<br>

## License

  (The MIT License)

  Copyright (c) 2011 Wagner Montalvao Camarao &lt;functioncallback@gmail.com&gt;

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, sublicense,
  and/or sell copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included
  in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
  OR OTHER DEALINGS IN THE SOFTWARE.