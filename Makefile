STAGING_HOST=
STAGING_PATH=

SRC=./
BASE_DIR=$(shell pwd)
PROD_DIR=_book
PROD_PATH=$(BASE_DIR)/$(PROD_DIR)
STAGE_DIR=$(PROD_DIR)
STAGE_PATH=$(BASE_DIR)/$(STAGE_DIR)

compile:
	@cd code/spels && make

setup:
	@npm install -g gitbook-cli
	@gitbook install

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

build-book:
	gitbook build $(SRC) --output=$(PROD_DIR)

run-book:
	gitbook serve $(SRC)

staging: build
	git pull origin master && \
	rsync -azP ./$(STAGE_DIR)/* $(STAGING_HOST):$(STAGING_PATH)

publish: build
	-git commit -a && git push origin master
	git subtree push --prefix $(PROD_DIR) origin gh-pages

