require 'rails_helper'

RSpec.describe Stack, type: :model do
  it { should have_many(:cards).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
