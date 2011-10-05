test:

	@./node_modules/.bin/expresso \
	$(shell find test -name "*.test.js" -type f)

.PHONY: test