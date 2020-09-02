BIN = mdbook
GEN := $(shell which $(BIN) 2> /dev/null)
DOWNLOAD = https://github.com/rust-lang/mdBook/releases
PUBLISH_DIR = book
PUBLISH_BRANCH = master
BUILDER_BRANCH = builder
TMP_GIT_DIR = /tmp/lfe-casting-spels-git

default: build

define BINARY_ERROR

No $(BIN) found in Path.

Download $(BIN) from $(DOWNLOAD).

endef

build:
ifndef GEN
	$(error $(BINARY_ERROR))
endif
	@echo " >> Rebuilding book ..."
	@$(MAKE) backup-submodule-git
	@$(GEN) build
	@$(MAKE) restore-submodule-git


serve:
	@bash -c "trap \"$(MAKE) serve-cleanup\" EXIT; $(GEN) serve"

serve-cleanup: book-init build

run: serve

clean:
	@rm -f $(PUBLISH_DIR)/README.md

book-submodule:
	@git submodule add -b master `git remote get-url --push origin` $(PUBLISH_DIR)
	@git commit --author "LFE Maintainers <maintainers@lfe.io>" \
		-m "Added master branch as submodule ($(PUBLISH_DIR) dir)."

book-init:
	@git submodule update --init --recursive

backup-submodule-git:
	@echo " >> Backup-up book's git dir ..."
	@mkdir -p $(TMP_GIT_DIR)/
	@mv -v $(PUBLISH_DIR)/.git $(TMP_GIT_DIR)/

restore-submodule-git:
	@echo " >> Restoring book's git dir ..."
	@mv -v $(TMP_GIT_DIR)/.git $(PUBLISH_DIR)/

$(PUBLISH_DIR)/README.md:
	@echo '# Content for Casting SPELs in LFE' > $(PUBLISH_DIR)/README.md
	@echo 'Published at [lfe.io/books/casting-spels/](https://lfe.io/books/casting-spels/)' >> $(PUBLISH_DIR)/README.md
	@cd $(PUBLISH_DIR) && git add README.md

publish: clean build $(PUBLISH_DIR)/README.md
	-@cd $(PUBLISH_DIR) && \
	git add * && \
	git commit --author "LFE Maintainers <maintainers@lfe.io>" \
		-am "Regenerated book content." > /dev/null && \
	git push origin $(PUBLISH_BRANCH) && \
	cd -  && \
	git add $(PUBLISH_DIR) && \
	git commit --author "LFE Maintainers <maintainers@lfe.io>" \
		-am "Updated submodule for recently generated book content." && \
	git submodule update && \
	git push origin $(BUILDER_BRANCH)

build-publish: build publish

spell-check:
	@for FILE in `find . -name "*.md"`; do \
	RESULTS=$$(cat $$FILE | aspell -d en_GB --mode=markdown list | sort -u | sed -e ':a' -e 'N;$$!ba' -e 's/\n/, /g'); \
	if [[ "$$RESULTS" != "" ]] ; then \
	echo "Potential spelling errors in $$FILE:"; \
	echo "$$RESULTS" | \
	sed -e 's/^/    /'; \
	echo; \
	fi; \
	done

add-word: WORD ?= ""
add-word:
	@echo "*$(WORD)\n#" | aspell -a > /dev/null

add-words: WORDS ?= ""
add-words:
	@echo "Adding words:"
	@for WORD in `echo $(WORDS)| tr "," "\n"| tr "," "\n" | sed -e 's/^[ ]*//' | sed -e 's/[ ]*$$//'`; \
	do echo "  $$WORD ..."; \
	echo "*$$WORD\n#" | aspell -a > /dev/null; \
	done
	@echo

spell-suggest:
	@for FILE in `find . -name "*.md"`; do \
	RESULTS=$$(cat $$FILE | aspell -d en_GB --mode=markdown list | sort -u ); \
	if [[ "$$RESULTS" != "" ]] ; then \
	echo "Potential spelling errors in $$FILE:"; \
	for WORD in $$RESULTS; do \
	echo $$WORD| aspell -d en_GB pipe | tail -2|head -1 | sed -e 's/^/    /'; \
	done; \
	echo; \
	fi; \
	done

play:
	@cd code && $(MAKE) play
