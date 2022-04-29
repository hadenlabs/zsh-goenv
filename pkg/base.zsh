#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function goenv::install {
    goenv::internal::gobrew::install
}

function goenv::load {
    goenv::internal::gobrew::load
}

function goenv::post_install {
    message_info "Post Install ${GOENV_PACKAGE_NAME}"
    message_success "Success Install ${GOENV_PACKAGE_NAME}"
}

function goenv::upgrade {
    goenv::internal::gobrew::upgrade
}

function goenv::package::all::install {
    goenv::internal::packages::install
}

function goenv::package::install {
    goenv::internal::package::install "${@}"
}

function goenv::package::all::get {
    goenv::internal::packages::get
}

function goenv::package::get {
    goenv::internal::package::get "${@}"
}

function goenv::install::versions {
    goenv::internal::version::all::install
}

function goenv::install::version::global {
    goenv::internal::version::global::install
}
