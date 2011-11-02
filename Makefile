test:

	@./bin/cappuccino --coffee --color --verbose test

watch:

	@watchr test/autotest.watchr

.PHONY: test