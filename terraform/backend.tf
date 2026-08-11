terraform {
  backend "s3" {
    bucket = "eks-2048-statefile"
    key    = "path/to/my/key"
    region       = "eu-west-2"
    use_lockfile = true
  }
}
