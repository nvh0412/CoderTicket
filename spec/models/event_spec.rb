require 'rails_helper'

RSpec.describe Event, type: :model do

  let!(:events) { create_list(:event, 3) }

  it " should be ordered by alphabetical" do

  end

end
