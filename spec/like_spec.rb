require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'http://localhost/123',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'Title',
      text: 'Hi Max!',
      author_id: @user.id,
      likes_counter: 0,
      comments_counter: 0
    )
  end

  it 'post like_counter should increase by 1' do
    Like.create(author_id: @user.id, post_id: @post.id)
    Like.create(author_id: @user.id, post_id: @post.id)
    Like.create(author_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.likes_counter).to eq(3)
  end
end
