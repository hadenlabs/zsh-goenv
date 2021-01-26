#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function goenv::pkg::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_GOENV_PATH}"/pkg/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_GOENV_PATH}"/pkg/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_GOENV_PATH}"/pkg/linux.zsh
      ;;
    esac

    # shellcheck source=/dev/null
    source "${ZSH_GOENV_PATH}"/pkg/helper.zsh

    # shellcheck source=/dev/null
    source "${ZSH_GOENV_PATH}"/pkg/alias.zsh
}

goenv::pkg::main::factory

goenv::load
