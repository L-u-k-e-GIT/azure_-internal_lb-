
  


variable "MD_LOCATION" { 
 description = "Location Region"
 type = string
 default = ""
 
}


variable "MD_RG_NAME" { 
 description = "Resource Group Name"
 type = string
 default = ""
 
}

variable "MD_SUBNET_ID" {
  type        = string
  description = "ID della subnet"
  default     = ""
}

variable "MD_VM_NIC" {
 description = "Vm's NIC"
 type = map ( object (    {
      id                       = string
          }))  
}

variable "MD_VM_NIC_CONFIG" {
  type        = string
  description = "IP Configuration Name"
  default     = ""
}

variable "MD_LB_PORT" { 
 description = "Port to balance & Probe"
 type = string
 default = ""
}


variable "MD_LB_PROTOCOL" { 
 description = "Protocol to balance & Probe"
 type = string
 default = ""
}



## NAMING CONVENTION PREFIX

variable "MD_PROJECT_NAME" { 
 description = "Nome dello progetto"
 type = string
 default = ""
}


variable "MD_IIP_PREFIX" { 
 description = "Prefisso IP privato Load Balancer"
 type = string
 default = ""
}

variable "MD_ILP_PREFIX" { 
 description = "Prefix for Private Load Balancer Name"
 type = string
 default = ""
}

variable "MD_LBP_PREFIX" { 
 description = "Prefix for Private Load Balancer NameBackEndPool"
 type = string
 default = ""
}


variable "MD_LBHP_PREFIX" { 
 description = "Prefix for Load balancing Probe"
 type = string
 default = ""
}


variable "MD_LBR_PREFIX" { 
 description = "Prefix for Load balancing Rule"
 type = string
 default = ""
}



variable "MD_SUBSCRIPTION_PREFIX" { 
 description = "Prefisso del nome della subscription"
 type = string
 default = ""
}

variable "MD_REGION_PREFIX" { 
 description = "Region Prefix Name"
 type = string
 default = ""
}



