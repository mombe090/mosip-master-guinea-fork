variable "sandbox_name" { //Change this to your sandbox name.
  default = "wuri-sandbox"  // This is informational.  A tag will be added with this name.
}

variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default  = "10.20.0.0/16"
}

variable "private_subnet" {
  default = "10.20.20.0/24"
}

/* CentOS 7.8 image from AWS */
variable "install_image" {
  default = "ami-0dd861ee19fd50a16"
}

/* 4 CPU, 16 GB */
variable "instance_type" {
  default = "m5a.xlarge"
}

variable "private_key" {
  type = map(string)
  default = {
    "name" = "wuri-sandbox"  // Name as given while creating keys on AWS console
    "local_path" = "~/.ssh/wuri-sandbox.pem" // Location on the machine from where you are running terraform
  } 
}

/* Recommended not to change names */
variable "console_name" {
  default = "console.inu.gov.gn"  //
}

/* Recommended not to change names */
variable "kube_names" {
   type = list(string)
   default = [
     "mzmaster.inu.gov.gn",
     "test_mzworker0.inu.gov.gn",
     "test_mzworker1.inu.gov.gn",
     "test_mzworker2.inu.gov.gn",
     "test_mzworker3.inu.gov.gn",
     "test_mzworker4.inu.gov.gn",
     "test_mzworker5.inu.gov.gn",
     "test_mzworker6.inu.gov.gn",
     "test_mzworker7.inu.gov.gn",
     "test_mzworker8.inu.gov.gn",
     "test_dmzmaster.inu.gov.gn",
     "test_dmzworker0.inu.gov.gn"
   ]
}

/* Recommended not to change names */
variable "hosted_domain_name" {  // Do not change this name - has dependency on Ansible scripts 
  default = "sb"
}

