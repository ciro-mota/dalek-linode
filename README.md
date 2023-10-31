<h2>Dalek Linode</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" />
    <img alt="Linode" src="https://img.shields.io/badge/Linode-00A95C?style=for-the-badge&logo=Linode&logoColor=white" />
    <img alt="Last Commit" src="https://img.shields.io/github/last-commit/ciro-mota/dalek-linode?style=for-the-badge" />
</p>

Just like the Daleks, exterminate resources from your Linode account.

This project is inspired by what is <a href="https://github.com/rebuy-de/aws-nuke" target="_blank">aws-nuke</a> for automatic resource removal from an cloud provider account.

## ⚠️ Caution!

Be aware of the risks, you should not use this script in a production account.

To reduce the range and mitigate some problems, there are some safety precautions:

1. By default only a [few paid features](https://www.linode.com/pricing/) are covered by this script: Linodes (VMs), Volumes, NodeBalancers and LKE (Kubernets cluster).

2. Also by default, the script will check for the existence of tags with the string name `prod` or related tags and will ignore removing the resource that is associated with this tag.

3. This tool will not read or remove any other resources than those listed above.


## 💸 Use Cases

Linode charges you for the use of VMs [even if they are in a powered off state](https://www.linode.com/docs/products/platform/billing/#will-i-be-billed-for-powered-off-or-unused-services) and this can cause a huge cost issue for some people. So you can never simply forget to remove your instances after some testing. Including your tests with [Terraform](https://www.terraform.io/) that may have failed to apply or you forgot to `destroy` when finished.

With this script your resources will be deleted days at a time pre-scheduled by you with the help of GitHub actions.

## 🚀 Installation

- Create a [Linode Personal Access Token](https://www.linode.com/docs/products/tools/api/guides/manage-api-tokens/).
- Clone this repo.
- Create a repository secret (`Settings` » `Secret and variables` » `actions` » `Secrets`) named `LINODE_TOKEN` and insert your Linode Personal Access Token.

## 💻 Usage

- Edit the `linode-nuke.yml` uncommenting lines `4` and `5` and adjust the period in which you want the removal action to be performed. By default it will run daily at 3:33am.

```
schedule:
  - cron: "33 3 * * *"
```

## 🐳 Docker

You can also use a Docker container to run the script manually when you want.

- Clone this repo.
- In the Dockerfile file, edit the `LINODE_CLI_TOKEN` variable and insert your Linode Personal Access Token.
- Build.
- Exec.

## 🎁 Sponsoring

If you like this work, give me it a star on GitHub, and consider supporting it buying me a coffee:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?business=VUS6R8TX53NTS&no_recurring=0&currency_code=USD)