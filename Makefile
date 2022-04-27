# Basics zum Makefile:
#	https://makefiletutorial.com/#getting-started
#
# You can set these variables from the command line.
# BUILDDIR      = _build

.PHONY: help colors init init39 init310 clean tests freeze build deploy

.DEFAULT_GOAL := help

include ${DEV_MAKE}/colours.mk

GIT_INIT := $(shell test -d ".git")
BASE := $(shell basename $(CURDIR))
GIT_EXISTS=$(shell [ -d .git ] && echo 1 || echo 0 )

init init39: ENVIRONMENT := "d39"
init310: ENVIRONMENT := "d310"

INIT_COMMANDS=\
	"    activate ${ENVIRONMENT} &&"\
	"\n    pip freeze > requirements.txt &&"\
	"\n    python3 -m venv .v${BASE} &&"\
	"\n    source .v${BASE}/bin/activate &&"\
	"\n    pip install -r requirements.txt"

help:
	@echo
	@echo ${MESSAGE} $@
	@echo
	@echo "Please use \`make <${YELLOW}target${RESET}>' where <target> is one of"
	@echo
	@echo "    ${YELLOW}help                      ${GREEN}This help message${RESET}"
	@echo "    ${YELLOW}colors                    ${GREEN}For testing only - show the available colors${RESET}"
	@echo
	@echo "    ${YELLOW}init | init39 | init310   ${GREEN}git init + hint for environment setup${RESET}"
	@echo
	@echo "    ${YELLOW}clean                     ${GREEN}Cleans up all unnecessary files and dirs${RESET}"
	@echo "    ${YELLOW}test                      ${GREEN}Runs all tests in 'tests' folder${RESET}"
	@echo "    ${YELLOW}freeze                    ${GREEN}Alle notwendigen packages werden in 'requirements.txt' gesammelt${RESET}"
	@echo "    ${YELLOW}build                     ${GREEN}Build your setup${RESET}"
	@echo
	@echo "    ${YELLOW}deploy                    ${GREEN}Package wird gebaut. ${WHITE}'git push' muss per Hand ausgeführt werden!${RESET}"
	@echo
	@echo "${BLUE}Hints:${NC}"
	@echo "    Make sure the right python environment is activated!"
	@echo "     - '${YELLOW}activate d39 | activate${NC}' on cmdline"
	@echo "    '${YELLOW}pip3 install -e .${NC}' to install 'HelloWorld' for testing"
	@echo

colors: ## show all the colors
	$(call print_colours)

init init39 init310:
	@if [ ! -d ".git" ]; then git init; else echo "${RED}GIT already initialized!${RESET}"; fi

	@echo "${NAME}"
	@echo

	@echo "${YELLOW}To create your Python-Environment:${RESET}"
	@echo
	@echo ${INIT_COMMANDS}
	@echo

	$(shell (echo ${INIT_COMMANDS} | pbcopy))


#ifeq ($(GIT_EXISTS), 0)
#help2:
#	@echo "Help2"
#help2:
#	@echo "Help3"
#endif

freeze:
	pip freeze > requirements.txt

clean:
	rm -rf build dist

tests:
	pytest --verbosity=1 -W ignore::DeprecationWarning --color=yes tests

build:
	python3 setup.py bdist_wheel sdist

deploy: clean freeze build

all: deploy

