resource "oci_budget_budget" "oci_free_budget" {
  compartment_id = var.tenancy_ocid
  amount         = 1
  reset_period   = "MONTHLY"
  display_name   = "budget-oci-free"
  description    = "Budget mensal de R$1 para monitoramento de custos OCI Free Tier"
  target_type    = "COMPARTMENT"
  targets        = [oci_identity_compartment.compartment.id]
  freeform_tags  = var.tags
}

resource "oci_budget_alert_rule" "alert_50_percent" {
  budget_id      = oci_budget_budget.oci_free_budget.id
  threshold      = 50
  threshold_type = "PERCENTAGE"
  type           = "ACTUAL"
  display_name   = "alert-50-percent"
  description    = "Alerta ao atingir 50% do budget"
  message        = "Atenção: Você atingiu 50% do budget mensal de R$1 no OCI Free Tier."
  recipients     = var.budget_alert_email
  freeform_tags  = var.tags
}

resource "oci_budget_alert_rule" "alert_80_percent" {
  budget_id      = oci_budget_budget.oci_free_budget.id
  threshold      = 80
  threshold_type = "PERCENTAGE"
  type           = "ACTUAL"
  display_name   = "alert-80-percent"
  description    = "Alerta ao atingir 80% do budget"
  message        = "Urgente: Você atingiu 80% do budget mensal de R$1 no OCI Free Tier."
  recipients     = var.budget_alert_email
  freeform_tags  = var.tags
}
