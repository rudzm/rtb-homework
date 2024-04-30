## Wymagania

Zanim zaczniesz, upewnij się, że masz:
- Zainstalowany Terraform
- Utworzone konto Google Cloud Platform z odpowiednimi uprawnieniami
- Utworzony plik JSON z danymi uwierzytelniającymi konta usługi, który będzie używany przez Terraform
- Skonfigurowane narzędzia Google Cloud SDK (`gcloud`)

## Konfiguracja projektu Terraform

1. **Utwórz i zainicjalizuj projekt w GCP**:
   - Utwórz nowy projekt w Google Cloud Platform lub użyj istniejącego.

2. **Skonfiguruj Terraform**:
   - Utwórz katalog projektu i umieść pliki Terraform, w tym `main.tf`, `backend.tf`, `variables.tf`, i `terraform.tfvars`.
   - Ustaw wartości zmiennych w pliku `terraform.tfvars`:

3. **Skonfiguruj Github**
   - Utwórz sekrety `GCP_CREDENTIALS`, `GCP_PROJECT_ID`
   - Utwórz zmienne `REGION`, `SA_NAME`, `VN_NAME`

```hcl
project_id   = "your-gcp-project-id"
region       = "your-preferred-region"
bucket_name  = "your-gcs-bucket-name"  # nazwa kosza GCS dla backendu
allowed_port = 8080  # port do otwarcia w firewallu
vm_name      = "custom-vm-name"  # nazwa maszyny wirtualnej
artifact_registry_name = "custom-artifact-registry"  # nazwa rejestru artefaktów
