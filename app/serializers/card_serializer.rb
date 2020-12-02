class CardSerializer
  include JSONAPI::Serializer
  attributes :front, :back
  belongs_to :stack
end
