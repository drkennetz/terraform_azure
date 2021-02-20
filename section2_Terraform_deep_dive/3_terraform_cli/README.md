# Terraform CLI
 - For the certification, you need to know about a few CLI commands (besides init/plan/apply). Let's summarize a few of these commands in this lecture

## Use the commands:

| Command | Description |
| :-------: | :-----------: |
| terraform fmt | Format the *.tf files by entering `terraform fmt` or `terraform fmt filename.tf` |
| terraform taint | Ex: `terraform taint azurerm_virtual_machine.myvm` next tim eyou run `terraform apply` the instance my instance will be destroyed and recreated |
| terraform import | If you have already resources created manually and you want to manage them in tf, then first create the terraform code in a *.tf file, then run `terraform import resource_type.resource_name unique-identifier` |
| terraform workspace | new, list, show, select and delete TF workspaces |
| terraform state | manipulate the terraform state file. You can move (mv), remove (rm), list, pull, push, replace-provider within the state, and show the state |


 - should use `terraform fmt` before committing code to version control so everybody has the same format.
 
## Terraform workspaces
- Terraform starts with a **single workspace** "default"
- You can create a **new workspace** using `terraform workspace new`

```
$ terraform workspace new mytestworkspace
Created and switched to workspace "mytestworkspace"

You're now on a new, empty workspace. Workspaces isolate their state, so if you run "terraform plan" Terraform will not see any existing state for this configuration.
```

- Switching to another workspace (or back to default can be done with `terraform workspace select name-of-workspace`
- Once you are in a **new workspace** you'll have an empty state
- Your previous state is still accessible if you select the "default" workspace again
- When you run terraform apply in your new workspace you will be able to **re-create all the resources**, and those resources will be managed by this **new state** in this new workspace
- This can be useful if you for example want to **test something** in your code without making changes to your existing resources, for example create a new instance with encrypted root devices in a new workspace to test whether your new code works, rather than immediately trying this on your existing resource.

- To avoid **naming collisions** you can use the variable `terraform.workspace`

```
resource "azurerm_virtual_machine" "myvm" {
  name = "/myapp/myname-${terraform.workspace}"
  [...]
}
```
- Or only enable resource creation in a specific workspace:
```
resource "azurerm_virtual_machine" "myvm" {
 count = terraform.workspace == "default" ? 1 : 0
 [...]
}
```

- The workspaces cannot be used for a fully isolated setup that you'd need when you want to run terraform for multiple environments (staging / testing / prod)
- Even though a workspace gives you an "empty state", you're still sing the **same state**, the **same backend configuration** (workspaces are the technically equivalent of renaming your state file)
- Therefore workspaces only have limited use cases
- In real world scenarios, you typically use **re-usable modules** and really split out the state over multiple backends (for example your staging backend will be on Azure Blob Storage on your staging account, and your prod backend will be in an Azure Blob Storage bucket on the prod account, following **multi-account strategy**)

- You want environments (staging / test/ prod) fully isolated.

## Debugging modes
- If something goes really wrong, you hit a **bug**, or terraform just **"hangs"**, you ight want to **enable debugging mode**
- To enable more logging, you need to set the **TF_LOG environment variable**
- You can also prepend it to the terraform command on MacOS / Linux like this:
```
TF_LOG=DEBUG terraform apply
```
- On windows, in Powershell, you can use:
```
$Env:TF_LOG = "DEBUG"
```

- Valid log levels are:
  - TRACE
  - DEBUG
  - INFO
  - WARN
  - ERROR

