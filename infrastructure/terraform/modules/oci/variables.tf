# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

variable "disable_auto_retries" {
  type        = bool
  default     = false
  description = "Disable automatic retries for retriable errors. Automatic retries were introduced to solve some eventual consistency problems but it also introduced performance issues on destroy operations."
}
