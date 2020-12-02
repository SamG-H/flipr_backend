require 'rails_helper'

RSpec.describe Score, type: :model do
  it { should belong_to(:stack) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:percentage) }
end
