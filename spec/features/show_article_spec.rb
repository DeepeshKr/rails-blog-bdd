require "rails_helper"

RSpec.feature "Show article" do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
   
    @article = Article.create(title: "New article title", body: "article body for testing", user: @john)
    # @article = Article.create(title: "New article title", body: "article body for testing", user: @fred)
  end
  scenario "non signed in user show not see edit delete button" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "to non owner hide edit delete button" do
    login_as(@fred)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
    
  end
  
  scenario "signed in owner sees hide edit delete button" do
    login_as(@john)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    
    expect(current_path).to eq(article_path(@article))
    
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
    
  end
  
end