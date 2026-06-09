#!/usr/bin/env ksh
# -*- coding: utf-8 -*-
#
export GO111MODULES=auto
export GOENV_ROOT="${HOME}/.goenv"
export GOENV_ROOT_BIN="${GOENV_ROOT}/bin"
export GOBREW_ROOT_BIN="${HOME}/.gobrew/bin"
export GOBREW_CURRENT_BIN="${HOME}/.gobrew/current/bin"
export GOBREW_DOWNLOAD_URL="https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh"
export GOENV_MESSAGE_BREW="Please install brew or use antibody bundle luismayta/zsh-brew"
export GOENV_PACKAGE_NAME=goenv

export ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH=go1.21

export GOENV_VERSIONS=(
    1.24.11
    1.25.11
)
export GOENV_VERSION_GLOBAL="${JASPER_GOENV_VERSION_GLOBAL:-1.25.11}"

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
    # apidocs
    github.com/swaggo/swag/cmd/swag@latest
    # mocks
    github.com/zekrotja/schnittstelle/cmd/schnittstelle@latest
    github.com/vektra/mockery/v2@v2.38.0
    # scm git
    github.com/matsuyoshi30/gitsu@latest

    github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    github.com/projectdiscovery/httpx/cmd/httpx@latest
    # release
    github.com/goreleaser/goreleaser@latest
    # tools
    github.com/go-task/task/v3/cmd/task@latest
    honnef.co/go/tools/cmd/staticcheck@latest
    github.com/nektos/act@latest
    github.com/motemen/ghq@latest
    github.com/git-chglog/git-chglog/cmd/git-chglog@latest
    github.com/minamijoyo/myaws@latest
    gitlab.com/gitlab-org/cli/cmd/glab@main
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
    github.com/golangci/golangci-lint/cmd/golangci-lint@v1.62.2
    github.com/google/yamlfmt/cmd/yamlfmt@latest
    github.com/zricethezav/gitleaks@latest


    # format yaml, toml
    github.com/mikefarah/yq/v4@latest

    # direnv
    github.com/direnv/direnv/v2@latest

    # build
    github.com/aktau/github-release@latest
    # engine template
    github.com/hairyhenderson/gomplate/v3/cmd/gomplate@latest
    github.com/sganon/env-secrets@latest
    # emoji
    github.com/muandane/goji@latest
    # scan
    github.com/tomnomnom/assetfinder@latest
    # encryption
    filippo.io/age/cmd/...@latest
    # di
    github.com/google/wire/cmd/wire@latest
    # trace
    github.com/nxtrace/NTrace-core@latest

    # network
    github.com/mr-karan/doggo/cmd/doggo@latest

    # management
    github.com/ankitpokhrel/jira-cli/cmd/jira@latest

    # git
    github.com/jesseduffield/lazygit@v0.49.0

    # kubernetes
    sigs.k8s.io/kind@v0.27.0

    # grafana
    github.com/grafana/grafanactl/cmd/grafanactl@v0.0.6

    # testing
    go install github.com/onsi/gomega@latest

    go install github.com/josharian/impl@latest

    # Ginkgo moderno
    go install github.com/onsi/ginkgo/v2/ginkgo@latest

    go install github.com/dougm/goflymake@latest

    go install github.com/fatih/gomodifytags@latest

    go install github.com/cweill/gotests/...@latest

    # tools
    go install github.com/99designs/aws-vault@latest

    go install github.com/kardianos/govendor@latest

    go install github.com/zricethezav/gitleaks/v8@latest

    go install github.com/preslavmihaylov/todocheck@latest

    # build
    go install github.com/gobuild/gopack@latest

    # security
    go install github.com/owasp-amass/amass/v4/...@latest
)