# Resource Groups Demo
 - Learn more about Azure resource groups, and how arguments and attributes work in terraform

## Files
- 2 relevant files
  - vars.tf
  - resourcegroup.tf

### resourcegroup.tf

- How do I know what is needed for an azure resource group? DOCUMENTATION!
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
- name and location are required
- tags are optional, but recommended
  - I'd recommend using tags, because as you start to provision resources in a larger team, or across multiple teams, it helps to clarify the resource and billing.

- There is also an `id` that is given when the resource is exported.

- if you already have a resource group, but you didn't create it in terraform, you can import it by id:

```
terraform import azurerm_resource_group.example /subscriptions/0000000000-0000-0000-0000-000000000000/resourceGroups/example
```

## Console
- When you have deployed your resource group with `terraform apply`, you can test it in the console and retrieve values by attributes:

```
$ terraform console

> var.location
"centralus"
> azurerm_resource_group.demo.id
"/subscriptions/0000000000-0000-0000-0000-000000000000/resourceGroups/resource-group-demo"
> azurerm_resource_group.demo.name
"resource-group-demo"
> azurerm_resource_group.demo.location
"centralus"
> azurerm_resource_group.demo.tags
tomap({
  "CostCenter" = "0000"
  "env" = "resource-group-demo"
})
> azurerm_resource_group.demo.tags["env"]
"resource-group-demo"
```

- Tags help us to organize our resources. You can add tags to all the resources you want and then use it in billing to filter on that.
- Go to portal:
- search resource groups and "click"
- click "Add filter"
  - in the dropdown next to "Filter" under "Tags" you should see "env". When you click it, you should only see the "resource-group-demo" resource group.
  - If we click on the resource group, in the left panel, there are many things.
  - We can see "Cost analysis", and "Cost alerts" and these will be explained later in the course.

- when you are all done, tear it down so you don't pay for it with:
  - `terraform destroy`

[dkennetz@tf 2_Resource_Groups_Demo]$ terraform destroy

```bash
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.demo will be destroyed
  - resource "azurerm_resource_group" "demo" {
      - id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resource-group-demo" -> null
      - location = "centralus" -> null
      - name     = "resource-group-demo" -> null
      - tags     = {
          - "CostCenter" = "0000"
          - "env"        = "resource-group-demo"
        } -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.


Warning: "skip_credentials_validation": [DEPRECATED] This field is deprecated and will be removed in version 3.0 of the Azure Provider


Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.demo: Destroying... [id=/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resource-group-demo]
azurerm_resource_group.demo: Still destroying... [id=/subscriptions/00000000-0000-0000-0000-...000/resourceGroups/resource-group-demo, 10s elapsed]
azurerm_resource_group.demo: Still destroying... [id=/subscriptions/00000000-0000-0000-0000-...000/resourceGroups/resource-group-demo, 20s elapsed]
azurerm_resource_group.demo: Still destroying... [id=/subscriptions/00000000-0000-0000-0000-...000/resourceGroups/resource-group-demo, 30s elapsed]
azurerm_resource_group.demo: Still destroying... [id=/subscriptions/00000000-0000-0000-0000-...000/resourceGroups/resource-group-demo, 40s elapsed]
azurerm_resource_group.demo: Destruction complete after 45s

Destroy complete! Resources: 1 destroyed.
```
