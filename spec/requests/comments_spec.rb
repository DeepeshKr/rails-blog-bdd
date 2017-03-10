require "rails_helper"

RSpec.describe "Comments", type: :request do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    # login_as(@john)
    @article = Article.create!(title: "First one", body: "first body for article", user: @john)
  end
  
  describe 'POST/article/:id/comments/' do
    context 'with a non signed in user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "This is an awesome post"}}
      end
    
      it "redirect user to sign in page" do 
        flash_message = "Please sign in or sign up before you can post a comment"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context 'with a signed in user' do
      
      before do
        login_as(@fred)
        post "/articles/#{@article.id}/comments", params: {comment: {body: "This is an awesome post"}}
      end
    
      it "redirect user to article page" do 
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
end