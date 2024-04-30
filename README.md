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
   - Ustaw wartości zmiennych w pliku `terraform.tfvars`
   - Podczas `terraform init` podaj nazwę bucketu GCP

3. **Skonfiguruj Github**
   - Utwórz sekrety `GCP_CREDENTIALS`, `GCP_PROJECT_ID`
   - Utwórz zmienne `REGION`, `SA_NAME`, `VN_NAME`


