variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud Region"
  type        = string
  default     = "us-central1" # opcjonalnie ustaw wartość domyślną
}

variable "allowed_port" {
  description = "Port to allow in the firewall rule"
  type        = number # określenie typu danych jako liczba
  default     = 80     # domyślnie HTTP, zmień według potrzeb
}

variable "vm_name" {
  description = "Nazwa maszyny wirtualnej"
  type        = string
  default     = "e2-micro-vm" # domyślna nazwa, którą można zmienić
}

variable "backend_bucket_name" {
  description = "Nazwa kosza GCS dla backendu"
  type        = string
}

variable "artifact_registry_name" {
  description = "Nazwa rejestru artefaktów Google"
  type        = string
  default     = "my-artifact-registry"  # zmień według potrzeb
}

variable "startup_script" {
  description = "Skrypt rozruchowy do instalacji Dockera"
  type        = string
  default     = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
EOF
}