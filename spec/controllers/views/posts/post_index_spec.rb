require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'index page' do
    before(:each) do
      @user = User.create(name: 'Max', bio: 'Full-stack developer', photo: 'http://localhost/123', posts_counter: 3)
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

    it "Can see the user's profile picture." do
      visit user_posts_path(@user.id)
      expect(page).to have_xpath("//img[contains(@src,'http://localhost/123')]")
    end

    it "Can see the user's username." do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Max')
    end

    it 'Can see the number of posts each user has written.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(3)
    end

    it 'Can see posts title.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Post1')
      expect(page).to have_content('Post2')
      expect(page).to have_content('Post3')
    end

    it "Can see some of the post's body." do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Post text1')
      expect(page).to have_content('Post text2')
      expect(page).to have_content('Post text3')
    end

    it 'Can see the first comments on a post.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Comment1')
      expect(page).to have_content('Comment2')
    end

    it 'Can see how many comments a post has.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Comments: 2')
    end

    it 'Can see how many likes a post has.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Likes: 1')
    end

    it 'should render pagination' do
      12.times do |i|
        Post.create(
          title: "Title #{i + 2}",
          text: "Post text #{i + 2}",
          author_id: @user.id,
          comments_counter: 0,
          likes_counter: 0
        )
      end

      get user_posts_path(@user)
      expect(response).to have_http_status(:success)
      visit user_posts_path(@user.id)
      expect(page).to have_content('Pagination')
    end

    it 'Redirects to posts show page' do
      visit user_posts_path(@user.id)
      click_link 'Post1'
      expect(page).to have_current_path user_post_path(@user.id, @post_one.id)
    end
  end
end
