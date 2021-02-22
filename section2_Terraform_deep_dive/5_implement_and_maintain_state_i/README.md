# Implement and maintain state
- The **default backend** in terraform is the local backend, this requires no configuration
- A **terraform.tfstate** file will be written to your project folder
  - This is where the **state** is **stored**
  - Every time you run `terraform apply`, this **state** will be **changed**, and the file will be updated
- One you start working in a team, you are going to want to use a **remote backend**

## Working with a remote state
- Working with a remote state has **benefits**:
  - You can **easily work in a team**, as the state is separate from the code. Alternatively, you would have to commit the state to version control - which is far from ideal if you need to work in a team)
    - Example: someone will do local work, and then run terraform plan + apply. Only when that state is created and that state has been committed, can other members work on that state. 
  - A remote backend can **keep sensitive information off disk**
    - Azure Blob Storage supports **encryption at rest, authentication & authorization**, which protects your state file much more than having it on your disk / version control
  - **Remote operations**: terraform apply can run for a long time in bigger projects. Backends, like the "remote" backend, supports remote operations that are executed fully remote, so that the whole operation runs asynchronously. You don't need to be connected / keep your laptop running during the terraform apply (more about that later)

## Remote vs Local Backend
- Terraform init
  - Local backend:
    - Local file on disk
    - Local locking (-lock file)
  - Remote backend
    - Azure Blob Storage
    - Azure Storage leases for locking
    - Azure Blob Storage: At rest encryption, versioning
- Locks prevent simultaneous operations, so in remote, if you apply, no members of your team can modify state until the lock is released.
- This is crucial for development, to make sure states don't diverge.

## State Locking
- State **locking** ensures nobody can write to the state at the same time
- Sometimes, when terraform crashes, or a user's internet connection breaks during terraform apply, a lock will stay
- `terraform force-unlock <id>` can be used to force unlock the state, in case there is a lock, but nobody is running terraform apply
  - This command will not touch the state, it';ll just remove the lock file, so it's safe, as long as nobody is really still doing an apply
- There's also an option `-lock=false` that can be passed to terraform apply, which will not use the lock file. This is discouraged and should only be used when your locking mechanism is not working (you probably have bigger problems).
