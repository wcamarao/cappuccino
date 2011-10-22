test:

	@./node_modules/.bin/expresso \
	$(shell find test -name "*.test.coffee" -type f)

.PHONY: test