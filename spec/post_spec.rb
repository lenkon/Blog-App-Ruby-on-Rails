require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'validates presence of title' do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
  end

  it 'validates length of title' do
    post = Post.new(title: 'ab' * 126)
    expect(post).to_not be_valid
  end

  it 'validates comments_counter is greater than or equal to 0' do
    author = User.create!(name: 'Jane Doe', email: '12349@email.com', password: 'abcdef')
    post = Post.new(author:, title: 'Title', comments_counter: -5)
    expect(post).to_not be_valid
  end

  it 'validates likes_counter is greater than or equal to 0' do
    author = User.create!(name: 'Jane Doe', email: 'email123@email.com', password: 'abcdef')
    post = Post.new(author:, title: 'Title', likes_counter: -5)
    expect(post).to_not be_valid
  end

  it 'increments the author posts_counter by 1' do
    author = User.create!(name: 'Jane Doe', email: 'email234@email.com', password: 'abcdef')
    post = Post.create!(author:, title: 'Title', likes_counter: 0, comments_counter: 0)
    expect { post.save! }.to change { author.reload.posts_counter }.by(1)
  end

  it 'returns the five most recent comments' do
    author = User.create!(name: 'Jane Doe', email: 'email231@email.com', password: 'abcdef')
    post = Post.create!(title: 'Title', author:, likes_counter: 0, comments_counter: 0)

    5.times do
      Comment.create!(post:, text: 'Old comment', author:)
    end
    expect(post.five_recent_comments.length).to eq(5)
  end
end
