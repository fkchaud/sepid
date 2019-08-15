# frozen_string_literal: true

## PermisoAcceso
class AccessPermit < ApplicationRecord
  validates :useCaseName, presence: true
  validates :useCaseURL, presence: true
end