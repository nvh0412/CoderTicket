require 'rails_helper'

RSpec.describe Region, type: :model do
  it { should validate_inclusion_of(:name).in_array(['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong']) }
  it { should validate_uniqueness_of(:name) }
end
