require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: "Test Title", body: "Test Body" } }
  let(:invalid_attributes) { { title: "", body: "" } }
  let!(:blog_post) { create(:blog_post, user: user) }

  before { sign_in user }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response for existing post" do
      get :show, params: { id: blog_post.id }
      expect(response).to be_successful
    end

    it "redirects to root for non-existent post" do
      get :show, params: { id: 'non-existent' }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BlogPost and redirects to it" do
        expect {
          post :create, params: { blog_post: valid_attributes }
        }.to change(BlogPost, :count).by(1)
        expect(response).to redirect_to(BlogPost.last)
      end
    end

    context "with invalid params" do
      it "renders the 'new' template" do
        post :create, params: { blog_post: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: blog_post.id }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates and redirects to the blog_post" do
        put :update, params: { id: blog_post.id, blog_post: valid_attributes }
        blog_post.reload
        expect(blog_post.title).to eq(valid_attributes[:title])
        expect(blog_post.body).to eq(valid_attributes[:body])
        expect(response).to redirect_to(blog_post)
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        put :update, params: { id: blog_post.id, blog_post: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the blog_post and redirects to index" do
      expect {
        delete :destroy, params: { id: blog_post.id }
      }.to change(BlogPost, :count).by(-1)
      expect(response).to redirect_to(blog_posts_url)
    end
  end
end

