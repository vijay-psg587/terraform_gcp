# GCP terraform with modules

This project is all about creating terraform modules for GCP

## **Commands**:
- `terraform init` -  Make sure to initinalize all modules before using
- `terraform init -reconfigure` - To reinitialize the modules once changes are done
- To test only the outputs  - `terraform refresh`
- `terraform validate` - Validate all changes
- `terraform plan -var"<key_name>=value"` - Any variables that are to be passed can be mentioned here
- `terraform plan -varfile=<lication of variables tf file>`
- `terraform apply -var=""` -  Apply all changes

## **Features used:**
   - **Data source**
    - Made use of the network that is already created - `test-vpc`. Made use of [data_src](/modules/compute_vm/data_sources.tf) in **modules/compute_vm**
   - **Variables** - Passed dynamic variables for tags and labels. Tags and network name are passed from parent to child and can be reference with this codeblock in [main.tf](./main.tf). 
    `module "compute" {
  source      = "./modules/compute_vm"
  def_tag     = var.default_tags
  def_network = var.gcp_network_name
} `
  
   - **Output** =  List the ouput of data sources

### Modules:
 >- [Compute_VM](./modules/compute_vm/README.md)
 >-  [GKE](./modules/gke/README.md)

### Authentication:
Currently the authentication is done via `sa_key.json` file under **config/key_loc** directory. But the better way to do is via running terraform inside a GoogleVM or a cluster that uses a Google Service Account. This allows Terraform to authenticate to Google Cloud without a separate credential/authentication file. Ensure that the scope of the VM/Cluster is set to or includes https://www.googleapis.com/auth/cloud-platform.

#### Used Commands
 - `terraform init -reconfigure`
 - `terraform refresh -var-file=./config/variables/common.tfvars -var-file=./config/variables/compute_vm.tfvars -var-file=./config/variables/vpc.tfvars` - Only if needed be
 - `terraform plan -var-file=./config/variables/common.tfvars -var-file=./config/variables/compute_vm.tfvars -var-file=./config/variables/vpc.tfvars -out=./output/plan.json`
 - `terraform apply -var-file=./config/variables/common.tfvars -var-file=./config/variables/compute_vm.tfvars -var-file=./config/variables/vpc.tfvars`
 - `terraform destroy -var-file=./config/variables/common.tfvars -var-file=./config/variables/compute_vm.tfvars -var-file=./config/variables/vpc.tfvars`