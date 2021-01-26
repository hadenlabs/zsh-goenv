#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

export GOENV_ROOT="${HOME}/.goenv"
export GOENV_ROOT_BIN="${GOENV_ROOT}/bin"
export GOENV_MESSAGE_BREW="Please install brew or use antibody bundle luismayta/zsh-brew branch:develop"
export GOENV_PACKAGE_NAME=goenv
export GOENV_VERSIONS=(
    1.13.4
    1.14.2
    1.15.4
)
export GOENV_VERSION_GLOBAL=1.15.7
export GOENV_PACKAGES=(
    github.com/onsi/ginkgo/ginkgo
    github.com/onsi/gomega
    github.com/pengwynn/flint
    github.com/dougm/goflymake
    # ide
    github.com/mdempsky/gocode
    github.com/rogpeppe/godef
    golang.org/x/tools/cmd/goimports
    golang.org/x/tools/cmd/godoc
    golang.org/x/tools/cmd/gorename
    golang.org/x/tools/gopls@latest
    golang.org/x/tools/cmd/guru
    github.com/davidrjenni/reftools/cmd/fillstruct
    github.com/josharian/impl
    github.com/haya14busa/gopkgs/cmd/gopkgs
    github.com/godoctor/godoctor
    github.com/zmb3/gogetdoc
    github.com/fatih/gomodifytags
    github.com/cweill/gotests/...
    # tools
    github.com/99designs/aws-vault
    github.com/minamijoyo/myaws/myaws
    github.com/kardianos/govendor
    github.com/motemen/ghq
    # debug
    github.com/go-delve/delve/cmd/dlv
    # validators
    github.com/BurntSushi/toml/cmd/tomlv
    github.com/fzipp/gocyclo
    github.com/go-critic/go-critic/cmd/gocritic
    golang.org/x/lint/golint
    github.com/preslavmihaylov/todocheck
    # build
    github.com/gobuild/gopack
    github.com/aktau/github-release
    # engine template
    github.com/hairyhenderson/gomplate/v3/cmd/gomplate
)
