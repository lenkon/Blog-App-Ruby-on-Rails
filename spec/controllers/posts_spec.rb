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
    @post = Post.create(
      title: 'Title',
      text: 'Hi Max!',
      author_id: @user.id,
      likes_counter: 0,
      comments_counter: 0
    )
  end

  it 'renders index template with status OK for post' do
    get "/users/#{@user.id}/posts"
    expect(response).to render_template('index')
    expect(response.status).to eq(200)
  end

  it 'renders show template with status OK for a post' do
    get "/users/#{@user.id}/posts/#{@post.id}"
    expect(response).to render_template('show')
    expect(response.status).to eq(200)
  end

  it 'renders index template with correct placeholder text' do
    visit "/users/#{@user.id}/posts/"
    expect(page).to have_text('User posts')
  end

  it 'renders show template with correct placeholder text' do
    visit "/users/#{@user.id}/posts/#{@post.id}"
    expect(page).to have_text('Post details')
  end
end
