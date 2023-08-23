require 'rails_helper'

RSpec.describe 'Posts', type: %w[request feature] do
  before :each do
    @user = User.new(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'http://localhost/123',
      posts_counter: 0
    )
    @user.save
  end

  it 'renders index template with status OK for post' do
    get '/users/1/posts'
    expect(response).to render_template('index')
    expect(response.status).to eq(200)
  end

  it 'renders show template with status OK for a post' do
    get '/users/1/posts/3'
    expect(response).to render_template('show')
    expect(response.status).to eq(200)
  end

  it 'renders index template with correct placeholder text' do
    visit '/users/3/posts/'
    expect(page).to have_text('User posts')
  end

  it 'renders show template with correct placeholder text' do
    visit '/users/3/posts/3'
    expect(page).to have_text('Post details')
  end
end
