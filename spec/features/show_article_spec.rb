require "rails_helper"

RSpec.feature "Show article" do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
    @article = Article.create(title: "New article title", body: "article body for testing", user: @john)
  end
  
  scenario "show the article" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    
    expect(current_path).to eq(article_path(@article))
    
  end
  
end