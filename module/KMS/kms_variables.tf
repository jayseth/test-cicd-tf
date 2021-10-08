



variable "kms_key_desc" {

    description = "sets the description for kms key"
    
    type = string
  
}

variable "kms_key_deletion_window" {

    description = "Sets the deletion window for kms key in days"
    
  
}

variable "kms_key_usage" {

    description = "sets the intended use of the key (Valid values: ENCRYPT_DECRYPT or SIGN_VERIFY)"
    
    type = string
  
}

variable "kms_key_spec" {

    description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"
   
    type = string
  

}

variable "kms_key_enabled" {
    description = "Sets the key to be enabled or not"
   
    type = bool
  
}

variable "kms_key_rotation" {

    description = "Sets key rotation"
   
    type= bool
  
}

variable "kms_key_alias" {

    description = "sets alias for kms key"
    
    type= string
  
}

