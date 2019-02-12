HUGO := hugo
TIMESTAMP := `date`

.PHONY: all
all: build test deploy

.PHONY: watch
watch:
	$(HUGO) server -D --bind "0.0.0.0"

.PHONY: test
test:
	htmlproofer --http-status-ignore "999" public

.PHONY: build
build:
	hugo -t hermit

.PHONY: deploy
deploy:
	cd public && \
	git add . && \
	git commit -m "Site regenerated at $(TIMESTAMP)" && \
	git push origin master
