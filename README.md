# gcp-foundation 

Following the official [terraform-example-foundation](https://github.com/terraform-google-modules/terraform-example-foundation)

This repo is a monorepo where each folder has its own GitHub App Cloudbuild triggers

This repo provisions limited projects because of [billing-quota-increase](https://support.google.com/code/contact/billing_quota_increase)

## 0-bootstrap
1. Comment out backend.tf, provider.tf and apply terraform manually
1. Update backend.tf, provider.tf, cloudbuild-tf-*.yaml with values from terraform output
1. Integrate Github repo with Cloud Build via Github App trigger 
1. Create triggers manually: 0-bootstrap-plan, 0-bootstrap-pull-request-plan (optional) and 0-bootstrap-apply and configure them with included files filter as 0-bootstrap/** and custom cloudbuild yaml location as 0-bootstrap/cloudbuild-tf-apply.yaml for example for 0-bootstrap-apply trigger
1. gcp repos and build triggers created automatically as part of official 0-bootstrap are kept but not used
1. To make 0-bootstrap work on cloudbuild: Added additional roles to tf sa and added a role to cloudbuild sa to access artifactory repo 

## 1-org
1. Create triggers
1. Creating 2 projects: logging and dns hub until quota increase
1. Not creating hub n spoke projects until quota increase
1. Disabled audit data access logs and not sending log exports to cloud storage and pubsub

## 2-environments
1. Create triggers
1. Creating development host project only and not restricted host project

## 3-networks
1. Create triggers
1. Creating development shared vpc only and not restricted shared vpc

## findings
1. terraform sa and cloudbuild sa both needs permissions on a bucket or artifactory repo in case of impersonation