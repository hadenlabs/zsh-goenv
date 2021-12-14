#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

export GO111MODULES=auto
export GOENV_ROOT="${HOME}/.goenv"
export GOENV_ROOT_BIN="${GOENV_ROOT}/bin"
export GOBREW_ROOT="${HOME}/.gobrew"
export GOBREW_ROOT_BIN="${GOBREW_ROOT}/bin"
export GOBREW_CURRENT_BIN="${GOBREW_ROOT}/current/bin"
export GOENV_MESSAGE_BREW="Please install brew or use antibody bundle luismayta/zsh-brew branch:develop"
export GOENV_PACKAGE_NAME=goenv
export GOENV_VERSIONS=(
    1.15.7
    1.16.4
    1.17.5
)
export GOENV_VERSION_GLOBAL=1.17.5
export GOENV_PACKAGES=(
    github.com/onsi/gomega
    github.com/josharian/impl
    github.com/onsi/ginkgo/ginkgo
    github.com/dougm/goflymake
    github.com/fatih/gomodifytags
    github.com/cweill/gotests/...

    # tools
    github.com/99designs/aws-vault
    github.com/minamijoyo/myaws/myaws
    github.com/kardianos/govendor
    github.com/zricethezav/gitleaks/v7
    github.com/preslavmihaylov/todocheck

    # release
    github.com/goreleaser/goreleaser


    # build
    github.com/gobuild/gopack

)
export GOENV_INSTALL_PACKAGES=(
    github.com/pengwynn/flint@latest
    # ide
    github.com/mdempsky/gocode@latest
    github.com/rogpeppe/godef@latest
    golang.org/x/tools/cmd/goimports@latest
    golang.org/x/tools/cmd/godoc@latest
    golang.org/x/tools/cmd/gorename@latest
    golang.org/x/tools/gopls@latest
    golang.org/x/tools/cmd/guru@latest
    github.com/davidrjenni/reftools/cmd/fillstruct@latest
    github.com/haya14busa/gopkgs/cmd/gopkgs@latest
    github.com/godoctor/godoctor@latest
    github.com/zmb3/gogetdoc@latest
    # tools
    github.com/motemen/ghq@latest
    github.com/git-chglog/git-chglog/cmd/git-chglog@latest
    # debug
    github.com/go-delve/delve/cmd/dlv@latest
    # validators
    github.com/BurntSushi/toml/cmd/tomlv@latest
    github.com/fzipp/gocyclo/cmd/gocyclo@latest
    github.com/go-critic/go-critic/cmd/gocritic@latest
    golang.org/x/lint/golint@latest
    github.com/preslavmihaylov/todocheck@latest
    github.com/golangci/golangci-lint/cmd/golangci-lint@latest

    github.com/zricethezav/gitleaks@latest
    # build
    github.com/aktau/github-release@latest
    # engine template
    github.com/hairyhenderson/gomplate/v3/cmd/gomplate@latest
    github.com/sganon/env-secrets@latest
)
