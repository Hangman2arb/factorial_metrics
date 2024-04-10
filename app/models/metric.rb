class Metric < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true, numericality: true

  GROUPING_TYPES = %w[day hour minute]
  REFRESH_TIME = 60
end
