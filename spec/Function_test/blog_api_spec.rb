require 'rails_helper'

RSpec.describe "BlogPosts", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: 'Test Title', body: 'Test Body' } }
  let(:invalid_attributes) { { title: '', body: '' } }

  before do
    sign_in user
  end

  describe "GET /blog_posts" do
    it "lists all blog posts" do
      get blog_posts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /blog_posts/:id" do
    it "shows the blog post" do
      get blog_post_path(:id)
      expect(response).to have_http_status(:found)
    end

    it "redirects to root for non-existent post" do
      get blog_post_path('non_existent_id')
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /blog_posts/new" do
    it "renders the new blog post form" do
      get new_blog_post_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('New Blog Post')
    end
  end

  describe "POST /blog_posts" do
    context "with valid params" do
      it "creates a new BlogPost and redirects to it" do
        expect {
          post blog_posts_path, params: { blog_post: valid_attributes }
        }.to change(BlogPost, :count).by(1)
        expect(response).to redirect_to(BlogPost.last)
        follow_redirect!
        expect(response.body).to include(valid_attributes[:title])
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "not create new BlogPost" do
        post blog_posts_path, params: { blog_post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "GET /blog_posts/:id/edit" do
    it "renders the edit blog post form" do
      get edit_blog_post_path(:id)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PATCH /blog_posts/:id" do
    context "with valid params" do
      it "updates the blog post and redirects to it" do
        patch blog_post_path(:id), params: { blog_post: valid_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        patch blog_post_path(:id), params: { blog_post: invalid_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE /blog_posts/:id" do
    it "destroys the blog post and redirects to index" do
      expect delete blog_post_path(:id)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end
end
