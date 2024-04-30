provider "google" {
  #credentials = file("<YOUR_CREDENTIALS_JSON_FILE>")
  project = var.project_id
  region  = var.region
}

# Custom VPC configuration
resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

# Subnet configuration
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet"
  region        = var.region
  network       = google_compute_network.custom_vpc.id
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_service_account" "vm_service_account" {
  account_id   = "vm-service-account"  # identyfikator konta usługi
  display_name = "Service account for VM"
}

# Provisioning an E2 micro VM
resource "google_compute_instance" "e2_micro_vm" {
  name         = var.vm_name
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/cos-stable-109-17800-147-60" # Choose your preferred image
    }
  }

  metadata = {
    gce-container-declaration = "spec:\n  containers:\n  - name: dumy\n    image: dummy\n    stdin: false\n    tty: false\n  restartPolicy: Always\n# This container declaration format is not public API and may change without notice. Please\n# use gcloud command-line tool or Google Cloud Console to run Containers on Google Compute Engine."
  }

  service_account {
    email  = google_service_account.vm_service_account.email  # użycie konta usługi
    scopes = ["cloud-platform"]  # pełne uprawnienia do GCP
  }

  network_interface {
    network    = google_compute_network.custom_vpc.id
    subnetwork = google_compute_subnetwork.custom_subnet.name

    access_config {
      # Enables external IP address for the instance
      nat_ip = google_compute_address.external_ip.address
    }
  }
}

# Reserve an external IP address
resource "google_compute_address" "external_ip" {
  name   = "vm-external-ip"
  region = var.region
}

# Firewall rule to allow access from the internet on a specific port
resource "google_compute_firewall" "allow_custom_port" {
  name    = "allow-custom-port"
  network = google_compute_network.custom_vpc.id

  allow {
    protocol = "tcp"
    ports    = var.allowed_port
  }

  source_ranges = ["0.0.0.0/0"] # Allows connections from anywhere
}

resource "google_artifact_registry_repository" "my_registry" {
  repository_id     = var.artifact_registry_name  # użyjemy zmiennej dla nazwy rejestru
  project  = var.project_id  # ID projektu GCP
  location = var.region  # lokalizacja rejestru
  format   = "DOCKER"  # format rejestru, np. Docker
}

resource "google_artifact_registry_repository_iam_binding" "binding" {
  project = google_artifact_registry_repository.my_registry.project
  location = google_artifact_registry_repository.my_registry.location
  repository = google_artifact_registry_repository.my_registry.name
  role = "roles/artifactregistry.reader"
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}"
  ]
}
