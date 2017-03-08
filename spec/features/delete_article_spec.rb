require "rails_helper"

RSpec.feature "Delete Article" do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
    @article = Article.create(title: "New article title", body: "article body for testing", user: @john)
  end
  
  scenario "User deletes an article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content "The article has been deleted"
    expect(current_path).to eq(articles_path)
  end
end