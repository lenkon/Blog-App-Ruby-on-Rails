require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'validates post_counter is greater than or equal to 0' do
    user = User.new(posts_counter: -5)
    expect(user).to_not be_valid
  end
end
