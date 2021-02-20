- basic commands

 - The command you'll type the most is:

 `terraform apply`
 - This command will read your *.tf files and apply the terraform code to the cloud provider that you have configured.

- Terraform will output the changes it will make, and ask if it can make the changes.
- you can respond "yes" to apply changes, or use the auto-approve argument to automatically approve changes.

If you only want to run a "plan" to see the changes terraform would do without applying:
 - `terraform plan`

Every time you add a new module, a provider, or the first time you want to use terraform within a project directory, you have to run:
 - `terraform init`

When you finish a demo and you'd like to destroy the infrastructure you created, you run
 - `terraform destroy`

**NOTE:** Sometimes in Azure, (at the making of this video) it doesn't always work and you have to manually destroy resources.