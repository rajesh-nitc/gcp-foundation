# gcp-foundation 

Example repo showing how to build a secure foundation / landing zone on gcp with terraform. It is made up of following parts:

### 1. Foundations
We closely follow [terraform-example-foundation](https://github.com/terraform-google-modules/terraform-example-foundation) for core foundation, [terraform-example-foundation-app](https://github.com/GoogleCloudPlatform/terraform-example-foundation-app) for gke foundation and [cloud-foundation-fabric](https://github.com/terraform-google-modules/cloud-foundation-fabric) for data foundation.
- core foundation (0-5)
- gke foundation (10-14)
- data foundation (20-24)

### 2. Migrations
Following [cloud-foundation-fabric](https://github.com/terraform-google-modules/cloud-foundation-fabric) for vm migration with m4ce
- vm migration (30-31)

### 3. Modernizations
- managed ad (40-42)

## Org Hierarchy view
We used [gcp-org-hierarchy-viewer](https://github.com/GoogleCloudPlatform/professional-services/tree/main/tools/gcp-org-hierarchy-viewer) to generate the view:
```
🏢 budita.dev (157305482127)
 +-- 📁 fldr-bootstrap (818226860401)
 |   +-- 📦 prj-b-seed-6949
 |   +-- 📦 prj-b-cicd-98fa
 +-- 📁 fldr-common (161434909087)
 |   +-- 📦 prj-m4ce-c-host-11c7
 |   +-- 📦 prj-c-base-net-hub-74f5
 |   +-- 📦 prj-gke-c-infra-pipeline-e6f5
 |   +-- 📦 prj-gke-c-cicd-pipeline-7989
 |   +-- 📦 prj-data-c-infra-pipeline-fb29
 |   +-- 📦 prj-bu1-c-infra-pipeline-eedb
 |   +-- 📦 prj-c-dns-hub-c4a2
 |   +-- 📦 prj-c-logging-8083
 +-- 📁 fldr-development (267943501446)
     +-- 📦 prj-ad-d-mgmt-6b1d
     +-- 📦 prj-gke-d-clusters-3c96
     +-- 📦 prj-data-d-landing-0816
     +-- 📦 prj-data-d-dwh-3f33
     +-- 📦 prj-data-d-transformation-4f2b
     +-- 📦 prj-bu1-d-sample-base-9208
     +-- 📦 prj-d-shared-base-21a3
```
## Org IP Address Space view

budita.dev
- us-central1 10.0.0.0/16
  - Hub 10.0.0.0/18
    - sb 10.0.0.0/24
  - Dev 10.0.64.0/18
    - bu1 10.0.64.0/21
    - data 10.0.72.0/21
    - gke 10.0.80.0/21
    - ad 10.0.88.0/24
- us-west1 10.1.0.0/16
  - Hub 10.1.0.0/18
    - sb 10.1.0.0/24
  - Dev 10.1.64.0/18
    - bu1 10.1.64.0/21
    - data 10.1.72.0/21
    - gke 10.1.80.0/21
    - ad 10.1.88.0/24
- Dev Private Service 10.16.64.0/21
  - ad 10.16.64.0/24

## GKE Admins Repo view

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
## Validations
We have validated the foundations by deploying:
- Sample app in a private gke cluster
- Sample dataflow pipelines

## Costs
To save costs for personal organization, we have:  

- Disabled ```containerscanning.googleapis.com``` in ```prj-gke-c-cicd-pipeline-7989```
- Configured ```base_shared_vpc``` module to not create dns zones for net hub 
- Configured ```base_shared_vpc``` module to create dns zones for spoke vpcs on demand 
- Not enabled hierarchical firewall policies 
- Destroyed log sink to avoid streaming insert costs in case of bigquery 
- Destroyed kms key version in ```prj-b-cicd-98fa```
- Cleaned artifact registry images in ```prj-b-cicd-98fa``` and ```prj-gke-c-cicd-pipeline-7989```

**Warning**: Don't enable firewall insights api for personal org as it is a costly operation