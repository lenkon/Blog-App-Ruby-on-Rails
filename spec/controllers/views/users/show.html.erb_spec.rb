require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  describe 'show page' do
    before(:each) do
      @user_one = User.create(name: 'Max', bio: 'Full-stack developer', photo: 'https://placehold.co/200x200',
                              posts_counter: 0)
      @user_two = User.create(name: 'Jim', bio: 'Hiring Manager', photo: 'https://placehold.co/190x190',
                              posts_counter: 0)
      @post_one = Post.create(title: 'Post 1', text: 'Lorem ipsum', author_id: @user_one.id, comments_counter: 0,
                              likes_counter: 0)
      @post_two = Post.create(title: 'Post 2', text: 'Dolor sit amet', author_id: @user_one.id, comments_counter: 0,
                              likes_counter: 0)
      Post.create(title: 'Post 3', text: 'Dolor sit amet', author_id: @user_one.id, comments_counter: 0,
                  likes_counter: 0)
      Comment.create(text: 'comment 1', author_id: @user_two.id, post_id: @post_one.id)
    end

    # describe 'index page' do
    it "Can see the users's profile picture." do
      visit user_path(@user_one.id)
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/200x200')]")
    end

    it "Can see the users's username." do
      visit user_path(@user_one.id)
      expect(page).to have_content('Max')
    end

    it 'Can see the users number of posts' do
      visit user_path(@user_one.id)
      expect(page).to have_content('Number of posts: 3')
    end

    it "Can see the users's bio." do
      visit user_path(@user_one.id)
      expect(page).to have_content('Full-stack developer')
    end

    it 'Can see the first three posts' do
      visit user_path(@user_one.id)
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
    end

    it "Can see the links to all of a user's posts" do
      visit user_path(@user_one.id)
      expect(page).to have_selector(:link_or_button, 'See all posts')
    end

    it 'Redirects to user post show page' do
      visit user_posts_path(@user_one.id)
      expect(page).to have_current_path user_posts_path(@user_one.id)
    end

    it 'Redirects to all user posts page' do
      visit user_path(@user_one.id)
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user_one.id)
    end
  end
end
