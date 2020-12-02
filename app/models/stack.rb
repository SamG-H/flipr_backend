class Stack < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :scores, dependent: :destroy
  validates_presence_of :title
end
