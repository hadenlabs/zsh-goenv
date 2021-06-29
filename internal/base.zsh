#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function goenv::internal::goenv::install {
    message_info "Installing ${GOENV_PACKAGE_NAME}"
    git clone https://github.com/syndbg/goenv.git ~/.goenv
    goenv::internal::goenv::load
    message_success "Installed ${GOENV_PACKAGE_NAME}"
}

function goenv::internal::goenv::init {
    if [[ ! $(core::exists "goenv") && ! $(core::exists "go") ]]; then
        return
    fi
    local goenv_path goenv_global goroot
    goenv_path=$(go env GOPATH)
    goenv_global=$(goenv global)
    goroot=$(goenv prefix)
    if core::exists goenv; then
        eval "$(goenv init -)"
    fi
    [ -e "${GOPATH}/bin" ] && export PATH="${goenv_path}/bin:${PATH}"
    [ -e "${GOENV_ROOT}/versions/${goenv_global}/bin" ] && export PATH="${GOENV_ROOT}/versions/${goenv_global}/bin:${PATH}"
    export GOROOT="${goroot}"
}

function goenv::internal::goenv::load {
    goenv::internal::goenv::init
    [ -e "${GOENV_ROOT_BIN}" ] && export PATH="${PATH}:${GOENV_ROOT_BIN}"
    [ -e "${GOENV_ROOT}/shims" ] && export PATH="${GOENV_ROOT}/shims:${PATH}"
    if core::exists goenv; then
        [ -e "${GOENV_ROOT_BIN}" ] && export PATH="${GOROOT}/bin:${PATH}"
        [ -e "${GOPATH}/bin" ] && export PATH="${PATH}:${GOPATH}/bin"
    fi
}

function goenv::internal::package::install {
    if ! core::exists go; then
        message_warning "it's necessary have go"
        return
    fi
    GO111MODULE=on go get -u -v "${1}"
    message_success "Installed required Go packages"
}

function goenv::internal::packages::install {
    if ! core::exists go; then
        message_warning "it's necessary have go"
        return
    fi

    message_info "Installing required go packages"
    # binary will be $(go env GOPATH)/bin/golangci-lint
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)"/bin v1.41.0

    for package in "${GOENV_PACKAGES[@]}"; do
       GO111MODULE=on go get -u -v "${package}"
    done
    message_success "Installed required Go packages"
}

function goenv::internal::version::all::install {
    if ! core::exists goenv; then
        message_warning "not found goenv"
        return
    fi

    for version in "${GOENV_VERSIONS[@]}"; do
        message_info "Install version of go ${version}"
        goenv install "${version}"
        message_success "Installed version of go ${version}"
    done
    goenv global "${GOENV_VERSION_GLOBAL}"
    message_success "Installed versions of Go"

}

function goenv::internal::version::global::install {
    if ! core::exists goenv; then
        message_warning "not found goenv"
        return
    fi
    message_info "Installing version global of go ${GOENV_VERSION_GLOBAL}"
    goenv install "${GOENV_VERSION_GLOBAL}"
    goenv global "${GOENV_VERSION_GLOBAL}"
    message_success "Installed version global of go ${GOENV_VERSION_GLOBAL}"
}

function goenv::internal::goenv::upgrade {
    message_info "Upgrade for ${GOENV_PACKAGE_NAME}"
    local path_goenv
    path_goenv=$(goenv root)
    # shellcheck disable=SC2164
    cd "${path_goenv}" && git pull && cd -
    message_success "Upgraded ${GOENV_PACKAGE_NAME}"
}
