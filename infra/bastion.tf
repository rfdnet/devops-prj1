### DEPENDENCIES BEFORE TERRAFORM ###
# 
# AWS_PROFILE=default aws ec2 create-key-pair --region=us-west-2 --key-name bastion --query 'KeyMaterial' --output text > bastion.pem
# chmod 400 bastion.pem
#
### DEPENDENCIES AFTER TERRAFORM ###
# ssh -i bastion.pem ec2-user@[private-ip]

resource "aws_instance" "bastion" {
  ami                  = var.ami_type
  instance_type        = var.bastion_type
  subnet_id            = aws_subnet.public-us-west-2a.id
  key_name             = "bastion" //check dependencies!!!
  iam_instance_profile = aws_iam_instance_profile.demo-profile.name
  tags = {
    //Name = "bastion"
    
  }

  security_groups = ["${aws_security_group.sg-bastion-ingress.id}"]

  user_data = <<EOF
#!/bin/bash
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

# KUBECTL DOWNLOAD
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.2/2023-10-17/bin/linux/amd64/kubectl 
sudo chmod +x kubectl
sudo cp kubectl /usr/bin

# EKSCTL DOWNLOAD
#
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
EOF

  #   lifecycle {

  #     create_before_destroy = true //add this for BASTIONS!!
  #   }

}
