# Creating the file system
resource "aws_fsx_lustre_file_system" "fsx_lustre" {
  import_path      = "s3://${aws_s3_bucket.default.bucket}"
  storage_capacity = var.fsx_lustre_capacity
  subnet_ids       = [aws_subnet.fsx_lustre_sub.id]
}



# VPC and subnets are hard coded and can be removed and a module can be used

resource "aws_vpc" "main" {
  cidr_block = var.fsx_lus_vpc_cidr
  
}

resource "aws_subnet" "fsx_lustre_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.fsx_lus_sub_cidr
  
}

# Creating a bucket with random name
resource "aws_s3_bucket" "default" {
  bucket = "${random_pet.pet_name.id}-bucket"
}





# random name generator
resource "random_pet" "pet_name" {
  length    = 3
  separator = "-"
}

