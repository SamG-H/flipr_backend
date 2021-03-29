class StackSerializer
  include JSONAPI::Serializer
  attributes :title
  belongs_to :user
  has_many :cards
end
