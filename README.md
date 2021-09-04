# Brad Hull Graylog Challenge Code

## Problem Statement:
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

## Requirements
- Terraform
- AWSCLI installed and configured
- Ansible
- Ansible-Galaxy
- jmespath (either in your pip or installed to the system)
- Java 8 and Maven on the Prometheus host.
- the cloudalchemy.prometheus and cloudalchemy.grafana ansible roles installed.
- I used a purchased domain to test this, you need to have a domain available to run my code.
- Instance roles prepared for the EC2 instances. One for the Prometheus box so that it can query CloudWatch, and one for the Grafana boxes so they can use the RDS.
- A keypair set up for the EC2 instances.

## Architecture
- I tried my best to go with as cloud-native an approach as I could. The end result is not the prettiest due to my unfamiliarity with some of the technology, but it's nothing that couldn't be ironed out by someone with more familiarity.
- The static webpage is hosted in s3, one bucket for www.domain.com and one for domain.com, with a cloudfront handling caching and automatic redirects. Also included is the creation of an hosted zone and an SSL certificate. Metrics for this are sent to cloudwatch.
- Prometheus is run on an EC2 instance, and also is running a copy of the Cloudwatch Exporter for Prometheus (https://github.com/prometheus/cloudwatch_exporter) on port 9106.
- Grafana is run on two EC2 instances, and are behind an Application Load Balancer that also handles redirecting HTTP to HTTPS.
- A mysql RDS is created for the two Grafana instances to store data in.

## Usage:
- I have the terraform folders broken out into units for ease of being able to create/destroy sections of the challenge, but they can all be piled into one directory and run via `terraform init` `terraform plan` `terraform apply -auto-approve`
- that being said, the order in which I run the sections are: s3static -> CloudWatch -> Grafana.
- Manually connect to the prometheus host and install: default-jre and maven. pull down the Cloudwatch Exporter for Prometheus from the above link, build it with `mvn package`, and run it with `java -jar target/cloudwatch_exporter-*-SNAPSHOT-jar-with-dependencies.jar 9106 example.yml &` I have included my example config in the cloudwatchexporter directory.
- The ansible code should be run only when the CloudWatch and Grafana terraform instances are running, and once you've filled in the host data into the hosts file, and edited prometheus_playbook.yml and grafana_playbook.yml

## Known Limitations:
- The certificate ARN needs to be manually entered into ALB.tf. This can be changed to pass by reference by putting it in the same directory as ACM.tf and referring to it by object name. My reasons for splitting things out was explained above: made testing easier.
- The EC2.tf needs to be edited to include the correct instance roles and keypair name.
- Cloudwatch configuration requires manual entry of the two CloudFront IDs. I could more than likely configure a datasource to pull those.
- The cloudwatch exporter for prometheus is manually installed and configured. This can be scripted via ansible, but I was honestly just excited to get it running.
- Ansible playbooks and host files require editing to reflect IP addresses of hosts/servers.
- I'm going to apologize in advance for the jankineiss around Prometheus. I'm 100% unfamiliar with it, so it's very definitely the weakest part of this project.
- In early testing the ALB wasn't preventing redirect loops, I assume because it wasn't handling the redirects itself. I've added HTTPS redirecting to the terraform config, but I can't guarantee it's foolproof.
- I couldn't manage to get a shared database for the two Grafana hosts, so they're not technically HA, just two servers existing side by side under an LB. I have the terraform code create a database, but more troubleshooting is necessary for why grafana isn't playing nice with the DB. Perhaps pre-configuration of the database is in order? Or I can just build a sqlite host in EC2, but that goes against my attempt to make it as cloud-native as I could.
