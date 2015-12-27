require 'rails_helper'

RSpec.describe TicketType, type: :model do
  it { should belong_to(:event) }
end
