require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'show page' do
    before(:each) do
      @user = User.create(name: 'Max', bio: 'Full-stack developer', photo: 'http://localhost/123', post_counter: 3)
      @post_one = Post.create(title: 'Post1', text: 'Post text1', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      @post_two = Post.create(title: 'Post2', text: 'Post text2', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      Post.create(title: 'Post3', text: 'Post text3', author_id: @user.id, comments_counter: 0, likes_counter: 0)
      Comment.create(text: 'Comment1', author_id: @user.id, post_id: @post_one.id)
      Comment.create(text: 'Comment2', author_id: @user.id, post_id: @post_one.id)
      Comment.create(text: 'Comment3', author_id: @user.id, post_id: @post_two.id)
      Like.create(post_id: @post_one.id, author_id: @user.id)
    end

    it "Can see the post's title." do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Post1')
    end

    it 'Can see who wrote the post.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Max')
    end

    it 'Can see how many comments.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Comments: 2')
    end

    it 'Can see how many likes.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Likes: 1')
    end

    it 'Can see the post body.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Post1')
    end

    it 'Can see the username of each commentor.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Max')
    end

    it 'Can see the comment each commentor left.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('Comment1')
    end
  end
end
