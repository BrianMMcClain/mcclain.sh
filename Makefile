HUGO := hugo

.PHONY: all
all: build test

.PHONY: watch
watch:
	$(HUGO) server -D --bind "0.0.0.0"

.PHONY: test
test: build
	htmlproofer --http-status-ignore "999" public

.PHONY: build
build:
	hugo -t hermit
