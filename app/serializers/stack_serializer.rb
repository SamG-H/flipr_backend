class StackSerializer
  include JSONAPI::Serializer
  attributes :title
  has_many :cards
end
