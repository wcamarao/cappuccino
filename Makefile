test:

	@./bin/cappuccino --coffee --color --verbose test

watch:

	@watchr autotest.watchr

.PHONY: test