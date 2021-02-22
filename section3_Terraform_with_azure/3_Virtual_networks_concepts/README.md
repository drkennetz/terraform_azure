# Virtual Networks

- A **Virtual Network** or **VNet** provides you with a **private network** in Azure
- A VNet is the first resource you need to have before creating VMs and other services that need **private network connectivity**
- You need to specify the **location** (region) where you want to create a VNet and the **address space**
- The address space is the **private IP range** you can then use:
  - For example within the 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12 ranges
  - For a CIDR table, you can check out http://www.rjsmith.com/CIDR-Table.html
  - the trailing /number is a bitmask, and the larger the number, the lower the possible number of IP addresses will be available (because you are masking more).
  - This is a complex topic in and of itself, so I won't go into any more detail about CIDR ranges, but it is good to have seen them, as you will use them in your VNet provisioning.
  - Note: These are ranges, and the trailing mask specifies some numbers in the range are allowed
  
Important numbers to know are:

| Subnet Mask | CIDR Prefix | Total IP Addresses | Detail | Example |
| :---: | :---: | :---: | :---: | :---: |
| 255.0.0.0 | /8 | 16,777,216 | allow anything that matches the first 255 to access | 255.20.15.18 is allowed, 212.20.15.18 is not |
| 255.255.0.0 | /16 | 65,536 | allow anything that matches the first two 255.255 to access | 255.255.20.98 is allowed, 255.20.18.6 is not |
| 255.255.255.0 | /24 | 256 | allow anything that matches the first three 255.255.255 to access | 255.255.255.16 is allowed, 255.255.20.18 is not |
| 255.255.255.255 | /32 | 1 | only 1 IP address is allowed, the one matching the value passed | 255.255.255.255 is allowed, nothing else is |

Example:

If I pass the IP 192.16.20.0 with the CIDR Suffix as /24, that means these are all allowed:
 - 192.16.20.16, 192.16.20.212, 192.16.20.82, 192.16.20.91

These are not:
 - 192.16.18.16, 191.22.20.16, etc

If /24 is passed, the first 3 numbers must match exactly, the last number can be variable.

If you want to IP lock to a single computer (like the one you are working on) you can look up your ip address on the internet:
 - https://whatismyipaddress.com
 - You will see an IPv4 number.

In your VNet configuration, to lock out traffic from any computer that is not yours, you use a /32.
  - Let's say my IPv4 address is: 22.64.181.64
  - I only want traffic from my computer to be able to access my site. In my VNet configuration, I'd pass:
  - 22.64.181.64/32
  - This will only allow traffic from that exact IPv4 address to access your site (or VM).

**NOTE:** IP addresses beginning with 10.0.0.0/8, 192.168.0.0/16, 172.16.0.0/12, and 100.64.0.0/10  generally refer to **private** IP networks and aren't routed to externally.

## Subnets
- Once a VNet is created you can create subnets:
  - A subnet will be within the same VNet you initially created, it will just allow certain hosts (or host types) to use a subnet that is alike to the other resources in that subnet. Below are some examples.
  - This is not required, it is just **logical** and **logic** helps humans understand what is going on.
  - For example, if you create a 10.0.0.0/16 VNet, you could create the following subnets:
  - A subnet for your Virtual Machines:
    - VM Subnet: 10.0.0.0/21 (10.0.0.0 - 10.0.7.255)
  - Say you have less databases than VMs (likely), you can use a smaller range
  - A subnet for your databases:
    - Database subnet: 10.0.8.0/22 (10.0.8.0 - 10.0.11.255)
  - If you have even less load balancers than databases, you can use a smaller subnet still:
    - Load Balancer Subnet: 10.0.12.0/24 (10.0.12.0-10.0.12.255)
  - You then launch your VM within one specific subnet depending on its type

- When creating a subnet, azure will reserve **5 IP addresses** for own use:
  - x.x.x.0: Network address
  - x.x.x.1: Reserved by Azure for default gateway
  - x.x.x.2, x.x.x.3: Reserved by Azure to map the Azure DNS IPs to the VNet space
  - x.x.x.255: Network broadcast address

- For each subnet you create, Azure will create a default route table
- This ensures that IP addresses can be routed to other subnets, virtual networks, a VPN, or to the internet
- You can override the defaul routes by creating your own custom routes

| Address Prefix | Next hop type (target) |
| :---: | :---: |
| 10.0.12.0/24 if the VNet is 10.0.12.0/24 | Virtual Network |
| 0.0.0.0/0 | Internet |
| 10.0.0.0/8 | None |
| 192.168.0.0/16 | None |
| 172.16.0.0/12 | None |
| 100.64.0.0/10 | None |

- This will "hop" from top down. For example, if you traffic is routed to an IP address that matches any in the range of 10.0.12.0/24, it will stay within the virtual network.
- Next, it will try the internet, because someone on the internet can have any IP address
- The rest are routed to nowhere because they are for private use. These are added simply to make sure that other private networks are not used to try to route your traffic. If you do accidentally route to another private network, it won't work.
- There is an exception within Azure. If an traffic is routed within Azure, it will use its own routing and the traffic will not even be routed to the internet which is great for security.