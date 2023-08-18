require 'rails_helper'

RSpec.describe Post, type: :model do
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

  it 'postcreated is valid' do
    expect(@post).to be_valid
  end

  it 'post title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'A post likes should be numeric' do
    @post.likes_counter = 'One'
    expect(@post).to_not be_valid
  end

  it 'A post likes should be >= 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  it 'A post comments should be numeric' do
    @post.comments_counter = 'Hello'
    expect(@post).to_not be_valid
  end

  it 'A post comments should be >= 0' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'post_counter should increment user by 1' do
    user = User.find(@post.author_id)
    expect(user.posts_counter).to eq(1)
  end

  it 'should not accept greater than 250 character' do
    @post.title = '
    Friends, it’s true: the end of the decade approaches. It’s been a difficult,
     anxiety-provoking, morally compromised decade, but at least it’s been populated
     by some damn fine literature. The American essay was having a moment at the
     beginning of the decade, and Pulphead was smack in the middle.'
    expect(@post).to_not be_valid
  end

  it 'should return a user recent 5 comments' do
    user = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'http://localhost/123',
      posts_counter: 0
    )
    10.times.collect do
      Comment.create(text: 'Hi Max!', author_id: user.id, post_id: @post.id)
    end
    expect(@post.five_recent_comments.length).to eq(5)
  end
end
