class ScoreSerializer
  include JSONAPI::Serializer
  attributes :name, :percentage
  belongs_to :stack
end
