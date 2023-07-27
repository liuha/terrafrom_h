terraform {
  cloud {
    organization = "YOUR_ORGANIZATION"
    workspaces {
      name = "hashicat-azure"
    }
  }
}
