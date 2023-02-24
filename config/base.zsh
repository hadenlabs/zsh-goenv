#!/usr/bin/env ksh
# -*- coding: utf-8 -*-
#
export GO111MODULES=auto
export GOENV_ROOT="${HOME}/.goenv"
export GOENV_ROOT_BIN="${GOENV_ROOT}/bin"
export GOBREW_ROOT="${HOME}/.gobrew"
export GOBREW_ROOT_BIN="${GOBREW_ROOT}/bin"
export GOBREW_CURRENT_BIN="${GOBREW_ROOT}/current/bin"
export GOENV_MESSAGE_BREW="Please install brew or use antibody bundle luismayta/zsh-brew"
export GOENV_PACKAGE_NAME=goenv

export ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH=go1.18

export GOENV_VERSIONS=(
    1.18.1
    1.19.5
)
export GOENV_VERSION_GLOBAL=1.19.5

export GOENV_PACKAGES=(
    github.com/onsi/gomega
    github.com/josharian/impl
    github.com/onsi/ginkgo/ginkgo
    github.com/dougm/goflymake
    github.com/fatih/gomodifytags
    github.com/cweill/gotests/...

    # tools
    github.com/99designs/aws-vault
    github.com/kardianos/govendor
    github.com/zricethezav/gitleaks/v7
    github.com/preslavmihaylov/todocheck

    # build
    github.com/gobuild/gopack
    # scan
    github.com/projectdiscovery/subfinder
    github.com/projectdiscovery/httpx

    # security
    github.com/OWASP/Amass

)
export GOENV_INSTALL_PACKAGES=(
    github.com/pengwynn/flint@latest
    # k8s
    sigs.k8s.io/kustomize/kustomize/v5@latest
    github.com/particledecay/kconf@latest
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

    # scm git
    github.com/matsuyoshi30/gitsu@latest

    # release
    github.com/goreleaser/goreleaser@latest
    # tools
    honnef.co/go/tools/cmd/staticcheck@latest
    github.com/nektos/act@latest
    github.com/motemen/ghq@latest
    github.com/git-chglog/git-chglog/cmd/git-chglog@latest
    github.com/minamijoyo/myaws@latest
    # sec
    github.com/aquasecurity/tfsec/cmd/tfsec@latest
    # debug
    github.com/go-delve/delve/cmd/dlv@latest
    # validators
    github.com/BurntSushi/toml/cmd/tomlv@latest
    github.com/fzipp/gocyclo/cmd/gocyclo@latest
    github.com/go-critic/go-critic/cmd/gocritic@latest
    golang.org/x/lint/golint@latest
    github.com/preslavmihaylov/todocheck@latest
    github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    github.com/google/yamlfmt/cmd/yamlfmt@latest

    github.com/zricethezav/gitleaks@latest
    # build
    github.com/aktau/github-release@latest
    # engine template
    github.com/hairyhenderson/gomplate/v3/cmd/gomplate@latest
    github.com/sganon/env-secrets@latest

    # scan
    github.com/tomnomnom/assetfinder@latest
    # encryption
    filippo.io/age/cmd/...@latest
)
