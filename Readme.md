# mock.js

  mock.js is a javascript mocking library built on node.js' assert module.

## Installation

  Using the node package manager
  
    $ npm install mock.js

## Quick Start

  Import mock.js functions
  
    var $ = require('mock.js');
      , mock = $.mock
      , when = $.when
      , verify = $.verify
      , any = $.any;
    
  Let's take the following User class as example
  
    function User(name) {
      this.name = name;
      this.toString = function() {
        return "User name: " + this.name;
      };
      this.meet = function(someone) {
        return "Nice to meet you " + someone;
      };
    }
  
  Mock an existent object
    
    var user = new User('functioncallback');
    var mockedUser = mock(user);
    
    when(mockedUser).toString().thenReturn('Mocked user name');
    
    user.toString();       // returns "User name: functioncallback"
    mockedUser.toString(); // returns "Mocked user name"
  
  Verify that a method has called twice
  
    var mockedUser = mock(new User('functioncallback'));
    
    mockedUser.toString();
    mockedUser.toString();
    
    verify(mockedUser).toString().twice();
  
  Match method calls by arguments
  
    var mockedUser = mock(new User('functioncallback'));
    
    when(mockedUser).meet('foo').thenReturn('Hi foo'); // here, meet('foo') defaults to match equals('foo')
    
    mockedUser.meet('foo'); // returns "Hi foo"
    mockedUser.meet('bar'); // fails, as it doesn't match equals('foo')
    
    // another matching example on the same mock
    
    when(mockedUser).meet(any('number')).thenReturn('Hello, numberic value'); // now it will match any number
    
    mockedUser.meet(123); // returns "Hello, numeric value"
    mockedUser.meet('s'); // fails, as it's not a number
  
## Running Tests

  First, [download project source](https://github.com/functioncallback/mock.js/tarball/master) and install dependencies with npm
  
    $ npm install
  
  Then

    $ make test

## API

### Primary functions
  
    mock(object)
    when(mockedObject)
    verify(mockedObject)
  
### Functions within when(mockedObject) context
  
  These functions tell how a mock method should behave
  
    thenReturn(value)
    thenThrow(error)
    thenCall(callback)
  
### Functions within verify(mockedObject) context
  
  These functions verify that a mock method has been called a specific number of times
  
    allowing()
    never()
    once()
    twice()
    times(n)
    atLeast(n)
    atMost(n)
    between(n1, n2)
    only()
  
### Built-in matchers
  
  These functions strict a mock method to be called with arguments according to a specific condition
  
    equals(value)
    any(type)
    a(Class)
    an(Class)
    matching(regex)
    containing(text)
    startingWith(text)
    endingWith(text)
    not(matcher)
    anyOf([matcher, ...])
    allOf([matcher, ...])

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