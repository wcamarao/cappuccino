[![build status](https://secure.travis-ci.org/functioncallback/cappuccino.png)](http://travis-ci.org/functioncallback/cappuccino)
# cappuccino

### hot mocking library on jasmine and node.js

  It's built on [jasmine](http://pivotal.github.com/jasmine) and [node.js](http://nodejs.org), using the Arrange-Act-Assert pattern and extending [jasmine-node](https://github.com/mhevery/jasmine-node) for running specs from command-line.

## How it works

  You still write your jasmine specs, but by running them with cappuccino, it loads its mocking functions into the same context that jasmine has its testing functions, then it runs your specs with jasmine-node. Provided parameters will be passed along, so you can run your specs like:

    $ ./node_modules/cappuccino/bin/cappuccino [options] directory

  Options:

    --color            - use color coding for output
    --noColor          - do not use color coding for output
    -m, --match REGEXP - load only specs containing "REGEXPspec"
    -i, --include DIR  - add given directory to node include paths
    --verbose          - print extra information per each test run
    --coffee           - load coffee-script which allows execution .coffee files
    --junitreport      - export tests results as junitreport xml format
    --teamcity         - converts all console output to teamcity custom test runner commands. (Normally auto detected.)

## Installation

Using the node package manager

    $ npm install cappuccino

## Quick Start

### Given the following User prototype

    function User(name) {
      this.name = name;
    }

    User.prototype.toString = function() {
      return "User name: " + this.name;
    };

    User.prototype.meet = function(someone) {
      return "Nice to meet you " + someone;
    };

### Write a jasmine spec

    describe('User meetings', function () {
      it('should meet people like', function () {
        // ...
      });
    });

### Mock an existent object

    var user = new User('functioncallback');
    var mockedUser = mock(user);

### Stub a method to return a value

    upon(mockedUser).toString().thenReturn('Mocked user name');

    user.toString(); // returns "User name: functioncallback"
    mockedUser.toString(); // returns "Mocked user name"

### Verify that a method has called twice

    mockedUser.toString();
    mockedUser.toString();

    verify(mockedUser).toString().twice();

### Match a method call by argument value

    upon(mockedUser).meet('foo').thenReturn('Hi foo'); // here, meet('foo') defaults to match equals('foo')

    mockedUser.meet('foo'); // returns "Hi foo"
    mockedUser.meet('bar'); // fails, as it doesn't match equals('foo')

### Match a method call by argument type

    upon(mockedUser).meet(match.any('number')).thenReturn('Hello, numberic value'); // now it will match any number

    mockedUser.meet(123); // returns "Hello, numeric value"
    mockedUser.meet('s'); // fails, as it's not a number

### Run your specs with cappuccino

  Any parameter that you provide will be passed along to jasmine-node, so you can run your specs like:

    $ ./node_modules/cappuccino/bin/cappuccino --coffee --color --verbose spec

## API

### Primary functions

    mock(object)
    upon(mockedObject)
    verify(mockedObject)

### Built-in matchers

  These functions strict a mock method to be called with arguments according to specific conditions. They are available under the match object, so you should use match.any(type) or match.a(Class) for example.

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

### upon(mockedObject).doesSomething()

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

  Note: only() is a bit different - it stricts a method to be the only one called from a given mock.

## Running cappuccino specs

  First, [download source](https://github.com/functioncallback/cappuccino/tarball/master) and install dependencies with npm

    $ npm install

  Then

    $ make spec

  If you have [watchr](https://github.com/mynyml/watchr), you may run "make watch" to observe changes to source files and keep specs running automatically.

## Future directions

  Verification in order<br>
  API to extend matchers<br>

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