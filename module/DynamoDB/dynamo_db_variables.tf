

variable "billing_mode" {

    description = "Dynamo DB Billing Mode"
    default = "PAY_PER_REQUEST"
    type=string  
}

variable "db_name" {

    description = "Dynamo DB Name"
    default = "DB_1"
    type = string
  
}

variable "hash_key" {

    description = "hash key for db"
    default = "UserId"
    type = string

  
}

variable "range_key" {

    description = "range key for db"
    default = "key2"
    type=string
  
}

variable "ttl_enable" {
    description = "Indicates whether ttl is enabled (true) or disabled (false)"
    default = false
    type=bool
  
}

variable "ttl_attribute_name" {

    description = " The name of the table attribute to store the TTL timestamp in"
    default ="TimeToExist"
    type = string
  
}

variable "read_capacity" {

    description = "The number of read units for this table"
    default = 20

  
}

variable "write_capacity" {

    description = "The number of write units for this table"
    default = 20
  
}

variable "stream_enabled_dynamodb" {

    description = "Sets the streams to be enabled or disabled"
    default = false
    type=bool
  
}

variable "stream_view_type_dynamodb" {

    description = "Sets the information that is written to the stream when table is modified( Options:KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
    default = "NEW_AND_OLD_IMAGES"
    type = string
  
}