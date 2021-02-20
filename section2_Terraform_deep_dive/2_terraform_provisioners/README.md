# Terraform provisioners

## Ways to provision

- We have multiple ways of provisioning VMs
  - Local-provisioner (execute something locally after spinning up vm)
  - Remote-provisioner (execute something remotely on the VM)
  - Packer (build source image, then launch virtual machine based on that source image
  - Cloud init (using custom_data, pass provisioning to Azure API so VM can provision at creation)

## Provisioner info

- Provisioners (local-exec / remote-exec) are separate flows that cannot be fully controlled by terraform
 - Provisioners add a considerable amount of complexity and uncertainty
 - more coordination required: security groups need to be open, network access to the instances to run provisioning
- Therefore, you should only use provisioners as a last resort, when other approaches are not possible.

## What should you use them for?

 - For most use cases, you'll be able to use cloud init
   - Cloud init (custom_data in azurerm_linux_virtual_machine), will run after the virual machine will launch for the first time
   - other cloud providers have similar approach (Google Cloud has metadata, AWS user_data in aws_instance, etc)
 - Since Kubernetes & other container orchestrators are used for provisioning, virtual machine provisioning becomes less of an issue
   - Provisioning happens when building the container, then the container is launched on a container platform