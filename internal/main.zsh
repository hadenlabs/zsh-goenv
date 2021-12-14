#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function goenv::internal::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_GOENV_PATH}"/internal/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_GOENV_PATH}"/internal/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_GOENV_PATH}"/internal/linux.zsh
      ;;
    esac
}

goenv::internal::main::factory
goenv::internal::gobrew::load

if ! core::exists curl; then core::install curl; fi
if ! core::exists gobrew; then goenv::internal::gobrew::install; fi
