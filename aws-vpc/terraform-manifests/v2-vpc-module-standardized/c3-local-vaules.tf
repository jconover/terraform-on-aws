# Define Local Values

locals {
    owner = var.business_division
    environment = var.environment
    #name = "${local.environment}-${local.owner}-vpc"
    name = "${var.business_division}-${var.environment}"

    common_tags = {
        environment = local.environment
        owners = local.owner
    }

}
