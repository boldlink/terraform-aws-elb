CURRENT_DIR = $(shell pwd)
BASE_DIR := $(CURRENT_DIR)/examples/*
SUBDIRS := $(shell find $(BASE_DIR) -maxdepth 1 -type d)

.PHONY: all


tfinit:
	for number in $(SUBDIRS) ; do \
			cd $$number && terraform init ; \
	done

tfplan:
	for number in $(SUBDIRS) ; do \
			cd $$number && terraform plan ; \
	done

tfaplly:
	for number in $(SUBDIRS) ; do \
			cd $$number && terraform plan && terraform apply --auto-approve ; \
	done

tfdestroy:
	for number in $(SUBDIRS) ; do \
			cd $$number && terraform destroy --auto-approve ; \
	done

tfclean:
	for number in $(SUBDIRS) ; do \
			rm -rf $$number/.terraform* ; \
	done

examplescreate: tfinit tfaplly

examplesclean: tfdestroy tfclean
