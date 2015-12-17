require 'rails_helper'

RSpec.describe TicketType, type: :model do
  it { should belong_to(:event) }
  it { should validate_inclusion_of(:name).in_array(["courtside", "vip", "premium", "standard"]) }
  it { should validate_numericality_of(:max_quantity).is_less_than_or_equal_to(10) }
end
