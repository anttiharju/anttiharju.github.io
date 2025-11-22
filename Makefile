SHELL := /bin/sh
.ONESHELL:
.SHELLFLAGS := -eu -c
MAKEFLAGS += --warn-undefined-variables

permalinks:
	@./.github/actions/generate-permalinks/script.sh
.PHONY: permalinks

links:
	@./.github/actions/clickable-links/script.sh
.PHONY: links