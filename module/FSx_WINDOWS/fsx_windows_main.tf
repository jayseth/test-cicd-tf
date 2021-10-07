# Creating the file system
resource "aws_fsx_windows_file_system" "example" {
  active_directory_id = aws_directory_service_directory.new_directory.id
  storage_capacity    = var.fsx_win_capacity
  subnet_ids          = [aws_subnet.fsx_win_sub.id]
  throughput_capacity = var.fsx_win_throughtput_capacity
}



# VPC and subnets are hard coded and can be removed and a module can be used

resource "aws_vpc" "main" {
  cidr_block = var.fsx_vpc_cidr
  
}

resource "aws_subnet" "fsx_win_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.fsx_win_subids[0]
  availability_zone = var.fsx_win_sub_az[0]
  
}

resource "aws_subnet" "fsx_win_sub_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.fsx_win_subids[1]
  availability_zone = var.fsx_win_sub_az[1]
}

resource "aws_directory_service_directory" "new_directory" {
  name     = var.serv_directory_name
  password = var.serv_directory_password
  size     = var.serv_directory_size
  type     = var.serv_directory_type

  vpc_settings {
    vpc_id     = aws_vpc.main.id
    subnet_ids = [aws_subnet.fsx_win_sub.id,aws_subnet.fsx_win_sub_1.id]
  }

 
}
