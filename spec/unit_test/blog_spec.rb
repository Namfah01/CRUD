require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      blog_post = BlogPost.new(title: 'Test Title', body: 'Test Body')
      expect(blog_post).to be_valid
    end

    it 'is not valid without a title' do
      blog_post = BlogPost.new(title: nil, body: 'Test Body')
      expect(blog_post).to_not be_valid
    end

    it 'is not valid without a body' do
      blog_post = BlogPost.new(title: 'Test Title', body: nil)
      expect(blog_post).to_not be_valid
    end

    it 'is not valid without both title and body' do
      blog_post = BlogPost.new(title: nil, body: nil)
      expect(blog_post).to_not be_valid
    end
  end

  describe 'attributes' do
    it 'has a title' do
      blog_post = BlogPost.new(title: 'Test Title')
      expect(blog_post.title).to eq('Test Title')
    end

    it 'has a body' do
      blog_post = BlogPost.new(body: 'Test Body')
      expect(blog_post.body).to eq('Test Body')
    end
  end
end
