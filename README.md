# 📘 Highly Available (HA) Web Server on GCP Project

This project deploys a **highly available, auto-scaling web server** architecture on **Google Cloud Platform (GCP)** using **Terraform**, complete with a **global HTTP load balancer**, health checks, and managed instance group autoscaling.

---

## 🔄 Clone the Repository

Start by cloning the Terraform project from GitHub:

```bash
git clone https://github.com/tiqsclass6/gcp-highly-available-web-server.git
cd gcp-highly-available-web-server
```

## 📁 Project Structure

```text
terraform-ha-webserver/
├── 1-providers.tf
├── 2-vpc.tf
├── 3-security-group.tf
├── 4-nat.tf
├── 5-instance-template.tf
├── 6-backend.tf
├── 7-frontend.tf
├── 8-firewall.tf
├── 9-variables.tf
├── 10-outputs.tf
├── terraform.tfvars
```

---

## 🔧 Prerequisites

### ✅ Tools

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- A GCP account with billing enabled

---

## 🛠 Setup Instructions

### 1. Clone or Copy Files

Place all Terraform files in the same directory (`terraform-ha-webserver/`).

### 2. Configure Your Variables

Edit `terraform.tfvars` and provide your project details:

```hcl
project_id       = "your-gcp-project-id"
credentials_file = "path/to/your-service-account-key.json"
public_ip_cidr   = "203.0.113.25/32"  # Your IP for SSH access
```

You can also override `region` and `zone` in `terraform.tfvars`.

---

## 🚀 Deploy the Infrastructure

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Format Terraform

```bash
terraform fmt
```

### 5. Validate Terraform

```bash
terraform validate
```

### 6. Plan Terraform

```bash
terraform plan
```

### 7. Apply the Infrastructure

```bash
terraform apply
```

Type `yes` to confirm.

---

## 🌐 Access the Web Server

After deployment, Terraform will output the **load balancer IP**:

```bash
instance_group_console_url = "<YOUR-INSTANCE-GROUP-URL>"
load_balancer_ip = "<YOUR-LB-IP>"
load_balancer_url = "http://<YOUR-LB-IP>"
```

Visit it in your browser. You should see:

```text
Welcome to HA Web Server on <hostname>
```

### NOTE: Double check your VM instances to see if your hostname matches

---

## 📈 Test Autoscaling

1. Go to **Compute Engine → Instance groups**
2. Stop or delete an instance manually
3. A new instance will be created automatically by the autoscaler

---

## 📸 Take Screenshots for Verification

Before tearing down your environment, take the following screenshots for documentation:

- The **Load Balancer screen** in Google Cloud Console showing the IP and backend health.
- The **VM instances page** after manually stopping one instance to show autoscaling recovery.
- The **browser view of** `http://<YOUR-LB-IP>` showing the Apache welcome message.
- The **Terraform Code** and the **Project Structure** files within VS Code.

## 🧼 Destroy the Infrastructure

When you're done, clean up with:

```bash
terraform destroy
```

---

## 🛠 Troubleshooting

| Problem | Resolution |
|--------|------------|
| Load balancer shows error | Check if health checks are passing |
| Apache not responding | SSH into instance and check `systemctl status apache2` |
| SSH not working | Verify firewall rule and `access_config` on template |
| Autoscaling not triggering | Validate CPU target and simulate load |

---
