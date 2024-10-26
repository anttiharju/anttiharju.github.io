SHELL := /bin/sh
.ONESHELL:
.SHELLFLAGS := -eu -c
MAKEFLAGS += --warn-undefined-variables

.PHONY: permalinks

permalinks:
	@./.github/actions/generate-permalinks/script.sh
