require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :password }
  it { should validate_presence_of :email }
  it { should validate_length_of(:password).is_at_least(8) }
end
