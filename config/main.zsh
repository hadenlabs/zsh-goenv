#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function goenv::config::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_GOENV_PATH}"/config/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_GOENV_PATH}"/config/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_GOENV_PATH}"/config/linux.zsh
      ;;
    esac
}

goenv::config::main::factory