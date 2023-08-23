require 'rails_helper'

RSpec.describe 'Users', type: %w[request feature] do
  before :each do
    @user = User.new(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'http://localhost/123',
      posts_counter: 0
    )
    @user.save
  end

  it 'renders index template with status OK' do
    get '/users/'
    expect(response).to render_template('index')
    expect(response.status).to eq(200)
  end

  it 'renders show template with status OK' do
    get '/users/3'
    expect(response).to render_template('show')
    expect(response.status).to eq(200)
  end

  it 'renders index template with correct placeholder text' do
    visit '/users/'
    expect(page).to have_text('Users list')
  end

  it 'renders show template with correct placeholder text' do
    visit '/users/3'
    expect(page).to have_text('User profile')
  end
end
