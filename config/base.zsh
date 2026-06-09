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

  # ----------------------------------------------------------------------------
  # Kubernetes
  # ----------------------------------------------------------------------------

  sigs.k8s.io/kustomize/kustomize/v5@latest
  sigs.k8s.io/kind@v0.27.0
  github.com/particledecay/kconf@latest

  # ----------------------------------------------------------------------------
  # Go Development
  # ----------------------------------------------------------------------------

  golang.org/x/tools/gopls@latest
  golang.org/x/tools/cmd/goimports@latest
  golang.org/x/tools/cmd/gorename@latest
  golang.org/x/tools/cmd/guru@latest

  github.com/josharian/impl@latest
  github.com/fatih/gomodifytags@latest
  github.com/cweill/gotests/gotests@latest
  github.com/davidrjenni/reftools/cmd/fillstruct@latest

  # ----------------------------------------------------------------------------
  # Testing
  # ----------------------------------------------------------------------------

  github.com/onsi/ginkgo/v2/ginkgo@latest
  github.com/vektra/mockery/v2@v2.38.0

  # ----------------------------------------------------------------------------
  # API Documentation
  # ----------------------------------------------------------------------------

  github.com/swaggo/swag/cmd/swag@latest

  # ----------------------------------------------------------------------------
  # Dependency Injection
  # ----------------------------------------------------------------------------

  github.com/google/wire/cmd/wire@latest

  # ----------------------------------------------------------------------------
  # Release & Build
  # ----------------------------------------------------------------------------

  github.com/goreleaser/goreleaser/v2@latest
  github.com/go-task/task/v3/cmd/task@latest
  github.com/git-chglog/git-chglog/cmd/git-chglog@latest
  github.com/aktau/github-release@latest

  # ----------------------------------------------------------------------------
  # Git & SCM
  # ----------------------------------------------------------------------------

  github.com/jesseduffield/lazygit@v0.49.0
  github.com/motemen/ghq@latest
  github.com/matsuyoshi30/gitsu@latest
  gitlab.com/gitlab-org/cli/cmd/glab@main

  # ----------------------------------------------------------------------------
  # Quality & Linters
  # ----------------------------------------------------------------------------

  honnef.co/go/tools/cmd/staticcheck@latest
  github.com/golangci/golangci-lint/cmd/golangci-lint@v1.62.2
  github.com/go-critic/go-critic/cmd/gocritic@latest
  github.com/fzipp/gocyclo/cmd/gocyclo@latest
  golang.org/x/lint/golint@latest
  github.com/preslavmihaylov/todocheck@latest

  # ----------------------------------------------------------------------------
  # Security
  # ----------------------------------------------------------------------------

  github.com/zricethezav/gitleaks/v8@latest
  github.com/aquasecurity/tfsec/cmd/tfsec@latest
  github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  github.com/projectdiscovery/httpx/cmd/httpx@latest
  github.com/owasp-amass/amass/v4/cmd/amass@latest

  # ----------------------------------------------------------------------------
  # Infrastructure
  # ----------------------------------------------------------------------------

  github.com/minamijoyo/myaws@latest
  github.com/99designs/aws-vault@latest

  # ----------------------------------------------------------------------------
  # YAML / TOML
  # ----------------------------------------------------------------------------

  github.com/mikefarah/yq/v4@latest
  github.com/google/yamlfmt/cmd/yamlfmt@latest
  github.com/BurntSushi/toml/cmd/tomlv@latest

  # ----------------------------------------------------------------------------
  # Templates & Configuration
  # ----------------------------------------------------------------------------

  github.com/hairyhenderson/gomplate/v3/cmd/gomplate@latest
  github.com/sganon/env-secrets@latest
  github.com/direnv/direnv/v2@latest

  # ----------------------------------------------------------------------------
  # Debugging
  # ----------------------------------------------------------------------------

  github.com/go-delve/delve/cmd/dlv@latest

  # ----------------------------------------------------------------------------
  # Networking
  # ----------------------------------------------------------------------------

  github.com/mr-karan/doggo/cmd/doggo@latest

  # ----------------------------------------------------------------------------
  # Discovery
  # ----------------------------------------------------------------------------

  github.com/tomnomnom/assetfinder@latest
  github.com/nxtrace/NTrace-core@latest

  # ----------------------------------------------------------------------------
  # Productivity
  # ----------------------------------------------------------------------------

  github.com/ankitpokhrel/jira-cli/cmd/jira@latest

  # ----------------------------------------------------------------------------
  # Misc
  # ----------------------------------------------------------------------------

  filippo.io/age/cmd/...@latest
  github.com/grafana/grafanactl/cmd/grafanactl@v0.0.6
)