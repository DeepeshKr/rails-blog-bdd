require "rails_helper"

RSpec.feature "Delete Article" do
  
  before do
    @article = Article.create(title: "New article title", body: "article body for testing")
  end
  
  scenario "User deletes an article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content "The article has been deleted"
    expect(current_path).to eq(articles_path)
  end
end