require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_uniqueness_of(:name) }
end
