class Score < ApplicationRecord
  belongs_to :stack
  validates :name, presence: true
  validates :percentage, presence: true
end
