data "aws_ami" "ami"{
  most_recent = "true"
  name_regex  = "Centos-8-DevOps-Practice"
  owners      =  ["973714476881"]
}

resource "aws_instance" "instances" {
  for_each                  =  var.instances
  ami                       =  data.aws_ami.ami.image_id
  instance_type             =  each.value["type"]
  vpc_security_group_ids    =  ["sg-044088839c84c7c16"]
  tags = {
    Name = each.value["name"]
  }
}

variable "instances" {
  default = {
    catalogue = {
      name = "catalogue"
      type = "t3.micro"
    }
    user = {
      name = "user"
      type = "t3.small"
    }
  }
}

output "ec2" {
  value = aws_instance.instances["catalogue"].public_ip
}
## immature code
/*variable "names" {
  default = ["catalogue","user"]
}

variable "types" {
  default = ["t3.micro","t3.small"]
}

resource "aws_instance" "instances" {
 count                     = length(var.names)
 ami                       =  data.aws_ami.ami.image_id
 instance_type             =  var.types[count.index]
 vpc_security_group_ids    =  ["sg-044088839c84c7c16"]
 tags = {
   Name = var.names[count.index]
 }
}*/

##Little mature code
/*
resource "aws_instance" "instances" {
  for_each                  =  var.demo
  ami                       =  data.aws_ami.ami.image_id
  instance_type             =  var.demo[count.index]["type"]
  vpc_security_group_ids    =  ["sg-044088839c84c7c16"]
  tags = {
   Name = var.demo[count.index]["name"]
 }
}

variable "demo" {
   default = [
   {
      name = "catalogue"
      type = "t3.micro"
    },
    {
      name = "user"
      type = "t3.small"
    }
  ]
}
*/
