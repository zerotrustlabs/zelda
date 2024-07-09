data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = var.tfc_org_name
    workspaces = {
      name = var.tfc_network_workspace_name
    }
  }
}

# provider "aws" {
#   region  = data.terraform_remote_state.network.outputs.aws_region
# }

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "app" {
  count = var.instances_per_subnet * length(data.terraform_remote_state.network.outputs.private_subnet_ids)

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id              = data.terraform_remote_state.network.outputs.private_subnet_ids[count.index % length(data.terraform_remote_state.network.outputs.private_subnet_ids)]
  vpc_security_group_ids = data.terraform_remote_state.network.outputs.app_instance_security_group_ids

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  tags = {
    Project = data.terraform_remote_state.network.outputs.project_tag
  }
}

resource "aws_lb_target_group_attachment" "http" {
  count = length(aws_instance.app)

  target_group_arn = data.terraform_remote_state.network.outputs.lb_target_group_http_arn
  target_id        = aws_instance.app[count.index].id
  port             = 80
}