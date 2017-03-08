require "rails_helper"

RSpec.feature "Listing Articles" do
  # create 2 articles before the listing
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    # login_as(@john)
    @article1 = Article.create(title: "new title", body: "New article body 1", user: @john)
    @article2 = Article.create(title: "new title", body: "New article body 2", user: @john)
  end
  
  scenario "with arcticles created and user not signed in all article" do
    #check if the articles are listed
    visit "/"
    
    #expect both articles and body are present
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)
    
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end
  
  scenario "with arcticles created and user signed in all article" do
    #check if the articles are listed
    login_as(@john)
    visit "/"
    
    #expect both articles and body are present
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)
    
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
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