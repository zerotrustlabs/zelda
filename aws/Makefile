.SHELL := /usr/bin/bash

.PHONY: plan
plan: init
    cd $(terraform); terraform plan -detailed-exitcode

init:
    rm -rf $(terraform)/.terraform/*.tfstate
    cd $(terraform); terraform init;

