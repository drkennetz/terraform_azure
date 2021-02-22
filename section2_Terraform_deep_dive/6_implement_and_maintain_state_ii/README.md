# Implement and maintain state
- Supported **standard backends**:
  - Artifactory (artifact storage software)
  - Azurerm (azure)
  - Consul (hashicorp key value store)
  - Cos (Tencent cloud)
  - Etcd, etcdv3 (similar to consul)
  - Gcs (google cloud)
  - http
  - Kubernetes
  - Manta (also object storage)
  - oss (Alibabe cloud storage)
  - pg (postgres)
  - S3 (amazon)
  - Swift (openstack blob storage)

## Details
- Every backend will also have a **specific authentication method** (which is explained in the terraform docs on a per backend basis).
- The configuration is done with the terraform {} block:

Azure example:
```
terraform {
  backend "azurerm" {
    storage_account_name = "abcd1234"
    container_name = "tfstate"
    key = "prod.terraform.tfstate"
    use_msi = true
    subscription_id = "00000000-0000-0000-0000-000000000000"
    tenant_id = "00000000-0000-0000-0000-000000000000"
  }
}
```

S3 example:
```
terraform {
  backend "s3" {
    bucket = "mybucket"
    key = "path/to/my/key"
    region = "us-east-2"
  }
}
```

- You can also have a partial backend configuration, where you leave away some of the information
- This can be useful if you would like to use different backends when executing the code (for example: staging / qa / prod envs)
  - This is often then **scripted** with shell scripts that call terraform with the correct arguments - this is to avoid having to do this manually every time
- Most commonly this is used to **avoid having to hardcode secrets in the terraform files, which would end up in version control

- There are **3 ways to pass** this backend information:
  - interactively, when the information is missing, terraform init will ask for it (only works for required values in the backend configuration)
  - A file
  - Key/Value pairs

```
# Example with file:
terraform init -backend-config=path/to/file

# Example with passing Key/Value pairs:
terraform init -backend-config="storage_account_name=tfstorage" \
    -backend-config="container_name=tfstate" \
    -backend-config="access_key=$(az keyvault secret show --name tfstate-storage-key --value-name \
    tfseries-state-kv --query value -o tsv)" \
    -backend-config="key=terraform-tfstate"
```

- If at some point, you'd like to **update your state** file to reflect the "actual" state of your infrastructure, but you don't want to run terraform apply, you can run `terraform refresh`
  - `terraform refresh` will look at your infrastructure that has been applied and will update your state file to reflect any changes
  - it'll not modify your infrastructure, it'll only update your state file
  - This is often useful if you have outputs that need to be refreshed, or something changed outside terraform and you need to make terraform aware of it without having to run an apply

## Secrets in your state file IMPORTANT
- You need to be aware that **secrets can be stored in your state file**
  - For example, when you create a database, the **initial database password** will be in the state file
- If you have a **remote state**, then locally it'll **not be stored on disk** (it'll only be kept in memory when you run terraform apply)
  - As a result, storing state remotely can increase security
- Make sure your **remote state backend is protected sufficiently**
  - For example, for Azure Blob Storage, make sure:
    - only terraform admins have access to this
    - enable encryption at reast
    - every backend TLS is used when communicating with the backend

