# OKE Oracle Cloud Infrastructure - Free Tier

Cria automaticamente um cluster Kubernetes gratuito no Oracle Cloud (Always Free Tier) usando Terraform.

## O que é criado

- Compartment para organizar recursos
- VCN (Virtual Cloud Network) com Internet Gateway e NAT Gateway
- Subnet pública para Load Balancers (HTTPS liberado)
- Subnets privadas para API e Nodes do OKE
- Cluster OKE Basic (Kubernetes) com Node Pool ARM A1
- Budget mensal com alertas por email (50% e 80%)

---

## Pré-requisitos

| Requisito | Link |
|-----------|------|
| Conta Oracle Cloud | [Criar conta gratuita](https://www.oracle.com/cloud/free/) |
| Terraform | [Instalar Terraform](https://developer.hashicorp.com/terraform/install) |

---

## Configurar credenciais Oracle Cloud API

1. **Obter Tenancy OCID:** Console ☰ → Governance & Administration → Tenancy Details → Copiar OCID

2. **Obter User OCID:** Perfil (canto superior direito) → My Profile → Copiar OCID

3. **Obter Região:** Exibida no topo do console (ex: `sa-saopaulo-1`)

4. **Criar API Key:**
   - My Profile → API Keys → Add API Key
   - Cole sua chave pública ou gere uma nova
   - Copie o **Fingerprint** gerado

5. **Criar arquivo `~/.oci/config`:**
   ```ini
   [DEFAULT]
   user=ocid1.user.oc1..SEU_USER_OCID
   fingerprint=SEU_FINGERPRINT
   tenancy=ocid1.tenancy.oc1..SEU_TENANCY_OCID
   region=sa-saopaulo-1
   key_file=~/.oci/oci_api_key.pem
   ```

> [Documentação oficial de configuração](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm)

---

## Como usar

### 1. Configurar variáveis

Edite `terraform.tfvars` com seus dados:

```hcl
tenancy_ocid       = "ocid1.tenancy.oc1..seu_tenancy_ocid"
region             = "sa-saopaulo-1"
budget_alert_email = "seu@email.com"
```

### 2. Executar

```bash
terraform init     # Baixa plugins
terraform plan     # Visualiza mudanças
terraform apply    # Cria recursos (digite 'yes')
```

### 3. Destruir recursos

```bash
terraform destroy
```

---

## Estrutura

```
├── terraform.tfvars  # Suas configurações (EDITAR)
├── provider.tf       # Provider OCI
├── variables.tf      # Definição de variáveis
├── compartment.tf    # Compartment
├── network.tf        # VCN, subnets, gateways, security lists
├── oke.tf            # Cluster e Node Pool
├── budget.tf         # Budget e alertas
└── data.tf           # Data sources
```

---

## Links úteis

- [Terraform OCI Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
- [OCI Free Tier Limites](https://www.oracle.com/cloud/free/)
- [OKE Documentation](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)
- [Terraform CLI Commands](https://developer.hashicorp.com/terraform/cli/commands)
