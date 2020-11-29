require 'rails_helper'

RSpec.describe Card, type: :model do
  it { should belong_to(:stack) }

  it { should validate_presence_of(:front) }
  it { should validate_presence_of(:back) }
end
