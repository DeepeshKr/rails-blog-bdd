require "rails_helper"

RSpec.feature "Listing Articles" do
  # create 2 articles before the listing
  before do
    @article1 = Article.create(title: "new title", body: "New article body 1")
    @article2 = Article.create(title: "new title", body: "New article body 2")
  end
  
  scenario "List all article" do
    #check if the articles are listed
    visit "/"
    
    #expect both articles and body are present
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)
    
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article2.title)
    
  end
  
  scenario "User has no articles" do
    Article.delete_all
    #check if the articles are listed
    visit "/"
    
    #expect both articles and body are present
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_link(@article1.title)
    
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article2.title)
    
    within("h1#no-articles") do
      expect(page).to have_content("No Articles Found")
    end
    
  end
end