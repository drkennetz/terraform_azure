# Lesson
 - can declare variables with terraform
 - to test to see if things were declared properly, from inside the dir with main.tf type `terraform console`
 - in the terraform console, there are 2 ways to access vars (using this main.tf file)
   var.myvar
   "${var.myvar}"
   both print "hello terraform"
 - for the map:
   var.mymap prints the whole map
   var.mymap["mykey"] prints the value
 - lists:
   lists are denoted with []
   list indexing is 0 based
   var.mylist[0] prints first item
   can also use functions
   element(var.mylist, 1)
   element(var.mylist, 2)
   slice(var.mylist, 0, 2)

From now on, I am going to use the syntax without the braces and dollar signs.

Next in resource.tf, I have an example of how to provision a resource.

I pass a provider, and a resource to provision.

can provide variables in terraform.tfvars, as is shown in the example.

Since I have passed a provider, i have to run `terraform init` which downloads the provider plugin and creates a terraform.tfstate and a lock in this directory