output "vpc_id" {
  description="the default vpc name"
  value=aws_default_vpc.default_vpc.id
}

output "santa_first_subnet" {
  description="subnet for region a"
  value=aws_default_subnet.default_az1.id
}

output "santa_second_subnet" {
  description="subnet for region b"
  value=aws_default_subnet.default_az2.id
}
