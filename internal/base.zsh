#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function goenv::internal::install {
    message_info "Installing ${GOENV_PACKAGE_NAME}"
    curl -sLk https://git.io/gobrew | sh -
    message_success "Installed ${GOENV_PACKAGE_NAME}"
}

function goenv::internal::load {
    unset GOROOT
    [ -e "${GOBREW_ROOT_BIN}" ] && export PATH="${GOBREW_CURRENT_BIN}:${GOBREW_ROOT_BIN}:${PATH}"
    export GOPATH="${GOBREW_ROOT}/current/go"
}

function goenv::internal::package::get {
    if ! core::exists go; then
        message_warning "it's necessary have go"
        return
    fi
    GO111MODULE=on go get -v "${1}"
    message_success "Installed ${1} required Go packages"
}

function goenv::internal::package::install {
    if ! core::exists go; then
        message_warning "it's necessary have go"
        return
    fi
    GO111MODULE=on go install "${1}"
    message_success "Installed ${1} required Go packages"
}

function goenv::internal::packages::get {
    if ! core::exists go; then
        message_warning "it's necessary have go"
        return
    fi

    message_info "Installing required go packages"

    for package in "${GOENV_PACKAGES[@]}"; do
        goenv::internal::package::get "${package}"
    done
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

    for package in "${GOENV_INSTALL_PACKAGES[@]}"; do
        goenv::internal::package::install "${package}"
    done
    message_success "Installed required Go packages"
}

function goenv::internal::version::all::install {
    if ! core::exists gobrew; then
        message_warning "not found gobrew"
        return
    fi

    for version in "${GOENV_VERSIONS[@]}"; do
        message_info "Install version of go ${version}"
        gobrew install "${version}"
        message_success "Installed version of go ${version}"
    done
    gobrew use "${GOENV_VERSION_GLOBAL}"
    message_success "Installed versions of Go"

}

function goenv::internal::version::global::install {
    if ! core::exists gobrew; then
        message_warning "not found gobrew"
        return
    fi
    message_info "Installing version global of go ${GOENV_VERSION_GLOBAL}"
    gobrew install "${GOENV_VERSION_GLOBAL}"
    gobrew use "${GOENV_VERSION_GLOBAL}"
    message_success "Installed version global of go ${GOENV_VERSION_GLOBAL}"
}

function goenv::internal::upgrade {
    message_info "Upgrade for ${GOENV_PACKAGE_NAME}"
    curl -sLk https://git.io/gobrew | sh -
    message_success "Upgraded ${GOENV_PACKAGE_NAME}"
}
