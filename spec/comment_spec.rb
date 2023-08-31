require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#update_comments_counter' do
    it 'increments the post comments_counter by 1' do
      user = User.create!(name: 'Jane Doe', email: '12345@email.com', password: 'abcdef')
      post = Post.create!(author: user, title: 'Title', likes_counter: 0, comments_counter: 0)
      comment = Comment.new(author: user, post:, text: 'Comment')
      expect(post.comments_counter).to eq 0
      comment.save!
      post.reload
      expect(post.comments_counter).to eq 1
    end
  end
end
