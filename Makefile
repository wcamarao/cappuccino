spec:

	@./bin/cappuccino --coffee --color --verbose spec

watch:

	@watchr spec/autotest.watchr

.PHONY: spec