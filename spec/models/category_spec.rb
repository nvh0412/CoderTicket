require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_uniqueness_of(:name) }
  it { should validate_inclusion_of(:name).in_array(['Entertainment', 'Learning', 'Everything Else']) }
end
