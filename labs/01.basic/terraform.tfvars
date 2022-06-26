subnet_id     = "subnet-0909fa9db444c5d42"
ami           = "ami-052efd3df9dad4825" #ubuntu
instance_type = "t3.micro"
machine_name  = "my-ec2-test-instance"
tags = {
  Iteration = 2
  Email     = "dzu@nomail.com"
}
key_name = "acg_key"