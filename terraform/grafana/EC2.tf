data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "grafana01" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  iam_instance_profile = "EC2_PrometheusQueryRole"
  key_name = "aci_dell"
  tags = {
    Name = "Grafana01"
  }
}

resource "aws_instance" "grafana02" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  iam_instance_profile = "EC2_PrometheusQueryRole"
  key_name = "aci_dell"
  tags = {
    Name = "Grafana02"
  }
}

resource "aws_instance" "prometheus01" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  iam_instance_profile = "EC2_CloudWatchFull"
  key_name = "aci_dell"
  tags = {
    Name = "Prometheus01"
  }
}
