require 'rails_helper'

describe Ticket, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:ticket_type) }
  it { should validate_numericality_of(:quantity).is_less_than_or_equal_to(10) }
end
