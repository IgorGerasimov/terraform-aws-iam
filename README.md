## Configuration in this directory creates IAM group with users who are allowed to assume IAM roles.

Requirments: 
 - terraform 0.13 ( tested on 0.13.2) `https://github.com/tfutils/tfenv`
 - aws subscription
 - aws credentials

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Or the same with using of `Makefile`

```
make all - will validate and apply default configuration 
make destroy - destroy all resources and cleanup output files
```

1. Which resources will you use, and how will they interact?
     * The resources used are;
     * AWS Organizations
       - Consolidates and centrally manages multiple AWS accounts.
       - We will create four accounts within the organization.
       - users account only for user management
      * IAM
    - Create IAM groups, roles, and policies for controlling access to the AWS accounts and their respective resources

2. `terraform apply` will create 

   - users and groups 
     `Eugene, Milo, Abigail, Aidan` as `Developers` 
     `Santiago, Felix, Morgan`      as `Ops`

   - assign users to the groups
   - creates assumable roles for each group with permissions for example
     `developers` and `ops` 
   
   
  










Small useful tricks 

`Clean .terraform of huge files` - `git rm --cached --ignore-unmatch .terraform/`

