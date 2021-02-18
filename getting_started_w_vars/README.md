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

From now on, I am going to use the syntax without the braces and dollar signs