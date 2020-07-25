BIN = mdbook
GEN := $(shell which $(BIN) 2> /dev/null)
DOWNLOAD = https://github.com/rust-lang/mdBook/releases
PUBLISH_DIR = book

define BINARY_ERROR

No $(BIN) found in Path.

Download $(BIN) from $(DOWNLOAD).

endef

build:
ifndef GEN
	$(error $(BINARY_ERROR))
endif
	@$(GEN) build

serve:
	@$(GEN) serve

run: serve

clean:
	@rm -f $(PUBLISH_DIR)/README.md

book-init:
	@git submodule update --init --recursive

$(PUBLISH_DIR)/README.md:
	@echo '# Content for Casting SPELs in LFE' > $(PUBLISH_DIR)/README.md
	@echo 'Published at [lfe.io/books/casting-spels/](https://lfe.io/books/casting-spels/)' >> $(PUBLISH_DIR)/README.md
	@cd $(PUBLISH_DIR) && git add README.md

publish: clean build $(PUBLISH_DIR)/README.md
	-@cd $(PUBLISH_DIR) && \
	git commit -am "Regenerated book content." > /dev/null && \
	git push origin master
	-@git add $(PUBLISH_DIR) && \
	git commit -am "Updated submodule for recently generated book content." && \
	git submodule update && \
	git push origin builder

build-publish: build publish
