require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'http://localhost/123',
      posts_counter: 0
    )
  end

  it 'user created is valid' do
    expect(@user).to be_valid
  end

  it 'name should be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be >= 0' do
    @user.posts_counter = -1
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be integer' do
    @user.posts_counter = 'Hi'
    expect(@user).to_not be_valid
  end

  it 'should return users recent 3 posts' do
    user = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'http://localhost/123',
      posts_counter: 0
    )
    10.times.collect do
      Post.create(
        title: 'Title',
        text: 'Hi Max',
        author_id: user.id,
        likes_counter: 0,
        comments_counter: 0
      )
    end
    expect(user.recent_posts.length).to eq(3)
  end
end
