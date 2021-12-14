# Basics zum Makefile:
#	https://makefiletutorial.com/#getting-started
#
# You can set these variables from the command line.
# BUILDDIR      = _build

.PHONY: help colors init init39 init310 clean freeze build deploy

.DEFAULT_GOAL := help

# Define standard colors
# Weitere Infos:
#	https://gist.github.com/rsperl/d2dfe88a520968fbc1f49db0a29345b9
ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	BLUE         := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""
	RESET        := ""
endif

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
	@echo "    ${YELLOW}freeze                    ${GREEN}Alle notwendigen packages werden in 'requirements.txt' gesammelt${RESET}"
	@echo "    ${YELLOW}build                     ${GREEN}Build your setup${RESET}"
	@echo
	@echo "    ${YELLOW}deploy                    ${GREEN}Package wird gebaut. ${WHITE}'git push' muss per Hand ausgeführt werden!${RESET}"
	@echo

colors: ## show all the colors
	@echo "${BLACK}BLACK${RESET}"
	@echo "${RED}RED${RESET}"
	@echo "${GREEN}GREEN${RESET}"
	@echo "${YELLOW}YELLOW${RESET}"
	@echo "${LIGHTPURPLE}LIGHTPURPLE${RESET}"
	@echo "${PURPLE}PURPLE${RESET}"
	@echo "${BLUE}BLUE${RESET}"
	@echo "${WHITE}WHITE${RESET}"

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

build:
	python3 setup.py bdist_wheel sdist

deploy: clean freeze build

all: deploy

