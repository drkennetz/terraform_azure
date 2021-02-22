# Navigate terraform workflow

Write -> Plan -> Apply (Create)

- Write the code
- Plan on how this code will be deployed
- When you're happy about the plan, you apply the resources which will create your infrastructure based on the code you have written.

## Translation to terraform

- Write some of the code, then `terraform init`
  - init will download some of the modules by providers and any backends you may have configured from the state
- `terraform validate` will check to see your code is correct (syntax) won't make any connections to the code itself.
- will not check state.
- `terraform plan planfile` will write all the instructions on what to provision in your cloud provider to a plan file.
When you have to do another plan again, you will already know what will be applied because it will be in the planfile.

- `terraform apply planfile (-auto-approve)`
  - Why do we not want to run the plan twice?
  - With small infrastructure, it is fine to run the plan twice because it is quick.
  - with larger infrastructure, it can take a long time to run the plan, and it can become prohibitive to run twice, which is why we plan then -auto-approve

- Can also run `terraform apply` in the console (for smaller projects), which will:
  - First, run a `terraform plan`
  - display the plan, and ask you if everything is correct
  - if `yes` then it will create the resources.
  - if `no` (or anything that is not `yes`) it will cancel the apply
  - **NOTE:** this is not something you do in CI/CD system, because of that required manual input step.

## Bigger projets, use a target

- When we are developing bigger projects, we use a target: `terraform plan -target address planfile`
- `terraform apply planfile`
  - When we don't want to wait for hundreds of resources to be checked for a large project, (say we only made a change to one file), we can pass a target to check. 
  - Example: if we only want to check a virtual machine, we can pass the target for this resource. It will then only check this resource, and resources related to this resource to ensure everything is correct. It makes testing much quicker, but does not guarantee these changes will not break your environment.
  - This is only super useful during **development** to save time from the plan/apply phase during dev.
