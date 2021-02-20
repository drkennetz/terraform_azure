# Terraform basics

- Terraform uses providers, which are shipped separately from the core with their own versions

- Terraform core contains the language interpreter, the CLI, and how to interact with those providers

- doesn't contain code to interact with API of cloud providers. It is invoked in `terraform init`.

- cloud providers push new resources all the time, which is why they split the core component and the cloud provider componenent.

- terraform registry has all the providers listed on their site. Can just google terraform registry and then browse providers.

- You can publish your own providers and modules.

- You can also specify the minimum terraform version, and this is useful so that you know it will be consistent.

- Example in this main.tf

## Terraform versioning

- Terraform released breaking changes between 0.12, 0.13, 0.14, etc.

- Bugfixes are performed in patch releases 0.12.1, 0.12.2, etc
 - This does not include new features
 - Major.Minor.Patch
  - PATCH = bug fixes only
  - Minor = new feature
  - Major = possible breaking changes
 - Terraform is getting easier, but it is so new that it breaks often

## Terraform provider configurations
 - Once you are using a provider, you can also specify provider configurations
 - see provider_example.tf