# gcp-infra-with-terraform


# Terraform GCP Infrastructure

This project provisions a simple GCP infrastructure using Terraform and GitHub Actions:
- VPC with subnet
- Compute Engine instance
- Cloud Storage bucket (destroy-friendly)

## 🚀 Features
- Infrastructure as Code with Terraform
- GitHub Actions workflow for CI/CD
- One-click deployment and destruction from GitHub
- Safe for public repositories (no secrets committed)

---

## 🛠 Setup

### 1. Enable APIs in GCP
- Compute Engine API
- Cloud Storage API

### 2. Create Service Account
In **GCP Console → IAM & Admin → Service Accounts**:
- Assign roles: `Compute Admin`, `Storage Admin`, `Network Admin`
- Create a JSON key and save as `service-account.json` (do NOT commit it)

---

### 3. GitHub Secrets
Go to **Repo → Settings → Secrets and Variables → Actions**:
- `GCP_PROJECT_ID` → your GCP project ID
- `GCP_SA_KEY` → paste the contents of `service-account.json`

---

### 4. Local Development (Optional)
```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
terraform destroy
