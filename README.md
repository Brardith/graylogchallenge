# Brad Hull Graylog Challenge Code

- Problem Statement:
Within the span of a few hours, create a solution using Terraform,
Ansible, & AWS to provision a load-balanced static HTML page whose
metrics are collected by Prometheus & illustrated by Grafana.
The Terraform code should be able to automate provisioning of a Grafana
monitoring infrastructure in AWS, with considerations for a secure and
high-availability deployment. We encourage you to limit manual inputs where
possible and try to parameterize values in the modules. The Grafana application
itself should be run within an EC2 instance, but other AWS services are
appropriate for use in the infrastructure.
Store the resources necessary to do so in a Git repository (local or
remote) with a descriptive README.md file.
Beyond notation of usage & how the resources accomplish the goal,
highlight areas for improvement.
Note: Organization & proper notation thereof is very important.

- Usage:
terraform init -> terraform plan -> terraform apply

- Folders:
stash:
bits of code I made but am not *currently* using
