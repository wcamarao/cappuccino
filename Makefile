spec:

	@./bin/cappuccino --coffee --color --verbose spec

watch:

	@watchr spec/support/autotest.watchr

.PHONY: spec