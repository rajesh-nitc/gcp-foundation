# gcp-foundation 

Example repo for creating a reasonably secure foundation on gcp with terraform. It is made up of following parts:

- core foundation (0-5)
- gke foundation (50-54)
- data foundation (90-94)

and for each part, this repo closely follow [terraform-example-foundation](https://github.com/terraform-google-modules/terraform-example-foundation), [terraform-example-foundation-app](https://github.com/GoogleCloudPlatform/terraform-example-foundation-app) and [cloud-foundation-fabric/data-platform-foundations](https://github.com/terraform-google-modules/cloud-foundation-fabric/tree/master/data-solutions/data-platform-foundations).

## Org Hierarchy
### Final view

```
🏢 budita.dev (157305482127)
 +-- 📁 fldr-bootstrap (818226860401)
 |   +-- 📦 prj-b-seed-6949
 |   +-- 📦 prj-b-cicd-98fa
 +-- 📁 fldr-common (161434909087)
 |   +-- 📦 prj-c-base-net-hub-74f5
 |   +-- 📦 prj-gke-c-infra-pipeline-e6f5
 |   +-- 📦 prj-gke-c-cicd-pipeline-7989
 |   +-- 📦 prj-data-c-infra-pipeline-fb29
 |   +-- 📦 prj-bu1-c-infra-pipeline-eedb
 |   +-- 📦 prj-c-dns-hub-c4a2
 |   +-- 📦 prj-c-logging-8083
 +-- 📁 fldr-development (267943501446)
     +-- 📦 prj-gke-d-clusters-3c96
     +-- 📦 prj-data-d-landing-0816
     +-- 📦 prj-data-d-dwh-3f33
     +-- 📦 prj-data-d-transformation-4f2b
     +-- 📦 prj-bu1-d-sample-base-9208
     +-- 📦 prj-d-shared-base-21a3
```
via [GCP Organization Hierarchy Viewer](https://github.com/GoogleCloudPlatform/professional-services/tree/main/tools/gcp-org-hierarchy-viewer) tool

## GKE Foundation
### Platform Admins Repo view

```
.
├── budita-app
│   ├── acm
│   │   ├── cluster
│   │   │   └── privileged-container-constraint.yaml
│   │   ├── namespaces
│   │   │   └── frontend
│   │   │       ├── admin-role-binding.yaml
│   │   │       ├── allow-all-ingress-networkpolicy.yaml
│   │   │       ├── istio-egress-googleapis.yaml
│   │   │       ├── istio-egress-metadata.yaml
│   │   │       ├── namespace.yaml
│   │   │       └── quota.yaml
│   │   └── system
│   │       ├── README.md
│   │       └── repo.yaml
│   └── kustomize-bases
│       └── frontend
│           ├── deployment.yaml
│           ├── istio-gateway.yaml
│           ├── istio-route.yaml
│           ├── ksa.yaml
│           ├── kustomization.yaml
│           └── service.yaml
└── README.md
```
## Miscellaneous
### Save costs
To save costs for personal organization, we have destroyed resources not being used yet for e.g. DNS zones for hub network vpc and hub dns vpc and few others. See the column **```cost saving action```** in the table below:  

```
| Project ID                   | Service description    | SKU description                        | Usage unit          | Pricing                    | Cost saving action             |
| ---------------------------- | ---------------------- | -------------------------------------- | ------------------- | -------------------------- | ------------------------------ |
| prj-gke-c-cicd-pipeline-7989 | Vulnerability Scanning | Container Images Scanned               | count               |                            | disable container scanning api |
| prj-c-dns-hub-c4a2           | Cloud DNS              | ManagedZone                            | month               | no free tier               | destroy                        |
| prj-c-base-net-hub-74f5      | Cloud DNS              | ManagedZone                            | month               | no free tier               | destroy                        |
| prj-d-shared-base-21a3       | Cloud DNS              | ManagedZone                            | month               | no free tier               | keep                           |
| prj-d-shared-base-21a3       | Networking             | Firewall Policy coverage               | month               |                            | destroy                        |
| prj-c-logging-8083           | BigQuery               | Streaming Insert                       | mebibyte            |                            | destroy                        |
| prj-b-cicd-98fa              | Cloud KMS              | Active software symmetric key versions | active key versions |                            | manual destroy                 |
| prj-gke-c-cicd-pipeline-7989 | Artifact Registry      | Artifact Registry Storage              | gibibyte month      | Up to 0.5 GB is free       | clean                          |
| prj-b-cicd-98fa              | Artifact Registry      | Artifact Registry Storage              | gibibyte month      | terraform image is ~900 mb | keep                           |
```

### TODO
1. Istio addon is deprecated, use ASM as a standalone service
