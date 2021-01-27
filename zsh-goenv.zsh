#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install goenv for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#

# shellcheck disable=SC2034  # Unused variables left for readability
ZSH_GOENV_PATH=$(dirname "${0}")

# shellcheck source=/dev/null
source "${ZSH_GOENV_PATH}"/config/main.zsh

# shellcheck source=/dev/null
source "${ZSH_GOENV_PATH}"/internal/main.zsh

# shellcheck source=/dev/null
source "${ZSH_GOENV_PATH}"/pkg/main.zsh
