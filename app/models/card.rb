class Card < ApplicationRecord
  belongs_to :stack

  validates_presence_of :front, :back
end
