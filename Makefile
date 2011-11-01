test:

	@./node_modules/.bin/expresso $(shell find test -name "*.test.coffee" -type f)
	@./node_modules/jasmine-node/bin/jasmine-node --coffee --color --verbose test

.PHONY: test