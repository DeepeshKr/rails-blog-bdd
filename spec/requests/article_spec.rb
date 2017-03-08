require "rails_helper"

RSpec.describe "Articles", type: :request do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    # login_as(@john)
    @article = Article.create!(title: "First one", body: "first body for article", user: @john)
  end
  
  describe 'GET/article/:id/edit' do
    context 'with non signed in user' do
      before { get "/articles/#{@article.id}" }
      it "redirects to sign in page" do 
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing"
        expect(flash[:alert]).to eq flash_message
      end 
    end # context end
    
    context 'with signed non owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}"
      end  
    
      it "redirects to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own articles"
        expect(flash[:alert]).to eq flash_message
      end
    end # context end
    
    context 'with signed in user is owner' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}"
      end
      
      it "sucessfully edits article" do
        expect(response.status).to eq 200
      end
    end # context end
    
    context 'delete by signed non owner' do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}"
      end  
    
      it "redirects to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article"
        expect(flash[:alert]).to eq flash_message
      end
    end # context end
    
    context 'delete by signed in user and owner' do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end
      
      it "sucessfully deletes article" do
        expect(response.status).to eq 200
      end
    end # context end
    
  end
  describe 'GET/articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }
      it "handles existing article" do 
        expect(response.status).to eq 200
      end 
    end
    
    context 'with non-existing article' do
      before { get "/articles/xxxxxx"}
      it "handles non-exising article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  
  end
  
end