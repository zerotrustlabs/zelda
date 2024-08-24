TF_DIR := .
TF_PLAN := $(TF_DIR)/terraform.plan

COMMIT_MESSAGE := "Update"
BRANCH := main

# Initialize Terraform
init:
	terraform -chdir=$(TF_DIR) init

# Validate Terraform code
validate:
	terraform -chdir=$(TF_DIR) validate

# Format Terraform code
fmt:
	terraform -chdir=$(TF_DIR) fmt -recursive

# Plan Terraform deployment
plan: init
	terraform -chdir=$(TF_DIR) plan -out=$(TF_PLAN)

# Apply Terraform deployment
apply: plan
	terraform -chdir=$(TF_DIR) apply $(TF_PLAN)

# Destroy Terraform resources
destroy:
	terraform -chdir=$(TF_DIR) destroy

# Clean up Terraform plan file
clean:
	rm -f $(TF_PLAN)

.PHONY: init validate fmt plan apply destroy clean

#  Git commands
# Stage all changes
stage:
	git add .

# Add specific file(s)
add:
	git add $(file)

# Commit changes with a message
commit:
	git commit -m "$(COMMIT_MESSAGE)"

# Push changes to the remote repository
push:
	git push origin $(BRANCH)

# Combined command: stage, commit, and push
deploy: stage commit push

.PHONY: stage add commit push deploy