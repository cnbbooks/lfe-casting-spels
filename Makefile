STAGING_HOST=
STAGING_PATH=

SRC=./
BASE_DIR=$(shell pwd)
PROD_DIR=_book
PROD_PATH=$(BASE_DIR)/$(PROD_DIR)
STAGE_DIR=$(PROD_DIR)
STAGE_PATH=$(BASE_DIR)/$(STAGE_DIR)

compile: book
	@cd code/spels && make

check:
	@rebar3 as test eunit

repl:
	@cd code && make repl

otp-repl:
	@cd code/spels && make repl

shell:
	@rebar3 shell

clean:
	@rebar3 clean
	@rm -rf ebin/* _build/default/lib/$(PROJECT) _book

deps:
	@npm install -g gitbook-cli

setup:
	@gitbook install

book:
	gitbook build $(SRC) --output=$(PROD_DIR)

book-server:
	gitbook serve $(SRC)

staging: build
	git pull origin master && \
	rsync -azP ./$(STAGE_DIR)/* $(STAGING_HOST):$(STAGING_PATH)

publish: build
	-git commit -a && git push origin master
	git subtree push --prefix $(PROD_DIR) origin gh-pages

.PHONY: book

