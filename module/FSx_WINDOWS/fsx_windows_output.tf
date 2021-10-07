output "File_System_ID" {

  value = aws_fsx_windows_file_system.example.id
}


output "vpc_id" {

    value = aws_vpc.main.id
  
}

output "subnet_id" {

    value = aws_subnet.fsx_win_sub.id
  
}