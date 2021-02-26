# Network Security Groups (NSG)
- Network Security Groups **can filter traffic** from and to Azure resources
- A NSG **consists of security rules** which have the following params:
  - Name: **unique name** of the security group
  - Priority: A **number** between **100 and 4096,** with lower numbers processed first
  - **Source & destination IP range** (or alternatively a service tag / application security group)
    - where does the traffic come from, where does it go to? Match within an IP range
  - **Source & Destination Port Range**
  - **IP Protocol:** TCP / UDP / ICMP / Any
  - Direction: **incoming / outgoing**
  - Action: **Allow / Deny**
    - What am I going to do when this rule matches? Allow it, or deny it?

## NSG Terraform Example
- At this point, open network.tf, this contains the relevant terraform code for the NSG from the first steps demo
  - "allow-ssh" is the name of the rule
  - we have a name
  - location
  - resource group name
  - and a security rule corresponding to the name "allow-ssh"
    - This security rule is specifically for ssh configured traffic
  - This is now the security_rule that is attached to our network security group that allows ssh traffic to our VM
  - the traffic can be specific (if you assign a variable in the `var.ssh-source-address`)
  - it will allow ssh from anywhere if no IP range is specified in the variable

## Default NSG Rules from Azure
- A newly created NSG has these default **inbound rules**:
[!Default_Inbound_NSG](./Default_Inbound_NSG.PNG)

- 2 allow rules
  - The first allow rule has a higher priority than the deny rule, so it will allow all traffic from the virtual network
  - The second allow rule has a higher priority than the deny rule, so it will allow all traffic from the Azure Load Balancer (if one exists)
- 1 deny rule
  - The last rule is going to deny all ports and all IP's if no higher priority rule is specified

- A newly created NSG has these default **outbound rules**:
[!Default_Outbound_NSG](./Default_Outbound_NSG.PNG)
- 2 allow rules
  - The first allow rule has a higher priority than the deny rule, so it will allow all traffic to go to the virtual network
  - The second allow rule has a higher priority than the deny rule, so it will allow all traffic to the internet
    - You can add another rule here that blocks outbound traffic to the internet
    - or you can add a rule that says you need to pass through your own proxy before the internet to deny internet traffic and only allow traffic to the proxy vm
    - On the proxy VM, you might allow access to the internet, perhaps if the other VM had all rule management
- 1 deny rule
  
## Our Inbound NSG
- After applying this NSG to our Azure account, our inbound rules will look like this:
[!Our_Inbound_NSG](./Our_Inbound_NSG.PNG)
- 3 Allow rules
  - the 2 defaults were applied
  - Our "allow-ssh" rule was applied:
    - highest priority
    - our source is going to be star (meaning all IPs can ssh if they have the key) or an IP address that we specify (ex: 192.162.0.1/32) would allow a single IP with that address to ssh in
    