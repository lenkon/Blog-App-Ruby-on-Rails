require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  before(:each) do
    @user_one = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'https://placehold.co/200x200',
      post_counter: 0
    )

    @user_two = User.create(
      name: 'Jim',
      bio: 'Hiring Manager',
      photo: 'https://placehold.co/190x190',
      post_counter: 0
    )

    @post_one = @user_one.posts.create(title: 'Post 1', text: 'Lorem ipsum')
    @post_two = @user_one.posts.create(title: 'Post 2', text: 'Dolor sit amet')
    @comment = Comment.create(text: 'comment 1', author: @user_two, post: @post_one)
  end

  describe 'index page' do
    it 'displays user information on the User show page' do
      visit user_path(id: @user_one.id)
      expect(page).to have_content(@user_one.name)
      expect(page).to have_content(@user_one.bio)
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/200x200')]")
      expect(page).to have_content('Number of posts: 2')
    end

    it 'displays posts information on the User show page' do
      visit user_path(id: @user_one.id)

      expect(page).to have_content(@post_one.title)
      expect(page).to have_content(@post_one.text)
      expect(page).to have_content(@post_two.title)
      expect(page).to have_content(@post_two.text)
      expect(page).to have_content('See all posts')
    end

    it "redirects to post's index page when cliked on see all posts button" do
      visit user_path(id: @user_one.id)

      find("a[id='see-posts']").click
      sleep(2)
      current_path
      expect(current_path).to eq(user_posts_path(user_id: @user_one.id))
      expect(page).to have_content(@user_one.name)
      expect(page).to have_selector("img[src='#{@user_one.photo}']")
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content(@post_one.title)
      expect(page).to have_content(@post_one.text)
      expect(page).to have_content(@post_two.title)
      expect(page).to have_content(@post_two.text)
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Likes: 0')
      expect(page).to have_content(@user_two.name)
      expect(page).to have_content(@comment.text)
    end

    it 'redirects to post show page when clicking on a post' do
      visit user_path(id: @user_one.id)
      find("a[href='/user/#{@user_one.id}/posts]").click

      sleep(2)
      current_path
      expect(current_path).to eq(user_post_path(user_id: @user_one.id, id: @post_one.id))
    end
  end
end
