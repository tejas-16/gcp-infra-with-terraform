# 🚀 Terraform + GitHub Actions: GCP Infrastructure Deployment

This project automates the provisioning of **Google Cloud Platform (GCP)** infrastructure using **Terraform** and **GitHub Actions**.  
It creates:
- A **Custom VPC**
- A **Subnet**
- A **Compute Engine VM Instance**

The deployment is triggered **manually** from GitHub with user-defined inputs (project ID, VPC name, etc.).

---

## 📌 Features
- **Infrastructure as Code (IaC)** using Terraform.
- **Customizable** via workflow inputs (no need to edit `.tf` files).
- **Automated Deployment** with GitHub Actions.
- **Version Locking** to avoid breaking changes (`~> 5.0` provider constraint).
- Outputs the **VM's public IP** after deployment.

---

## 🛠 Project Structure
.
├── main.tf # Terraform resources (VPC, Subnet, VM)
├── variables.tf # Input variables for Terraform
├── provider.tf # GCP provider configuration
├── output.tf # Outputs (VM Public IP)
└── .github
└── workflows
└── deploy.yml # GitHub Actions workflow

---

## ⚙️ How It Works

### 1️⃣ GitHub Actions Workflow
- Triggered manually (`workflow_dispatch`).
- Takes **inputs** for:
  - `project_id`
  - `vpc_name`
  - `subnet_name`
  - `instance_name`
- Authenticates to GCP using a **Service Account Key** stored in GitHub Secrets (`GCP_SA_KEY`).
- Runs Terraform commands:
  - `terraform init`
  - `terraform validate`
  - `terraform plan`
  - `terraform apply`

---

### 2️⃣ Terraform Configuration
- **VPC** → Custom mode (no auto subnets).
- **Subnet** → CIDR `10.0.0.0/24`.
- **VM Instance** → Debian-based `e2-micro` with public IP.

---

## 🧩 Prerequisites
Before using this project, ensure you have:
1. **A GCP Project** with billing enabled.
2. **A Service Account** with these roles:
   - `Compute Admin`
   - `Network Admin`
   - `Viewer`
3. **Service Account Key JSON** stored in GitHub Secrets as GCP_SA_KEY.

## 🖼 Deployment Flow Diagram
```mermaid
flowchart LR
 A[You: Trigger Workflow] --> B[GitHub Actions CI/CD]
 B --> C[Terraform: Plan & Apply]
 C --> D[GCP Provider API]
 D --> E[VPC]
 D --> F[Subnet]
 D --> G[VM Instance]
