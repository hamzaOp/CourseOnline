require "rails_helper"
RSpec.feature "Users can view tickets" do
  before do
    author = FactoryGirl.create(:user)

    sublime = FactoryGirl.create(:course, name: "Sublime Text 3")
    assign_role!(author, :viewer, sublime)
    FactoryGirl.create(:ticket, course: sublime,
                       name: "Make it shiny!",author:author,
                       description: "Gradients! Starbursts! Oh my!")
    ie = FactoryGirl.create(:course, name: "Internet Explorer")
    assign_role!(author, :viewer, ie)
    FactoryGirl.create(:ticket, course: ie,author:author,
                       name: "Standards compliance", description: "Isn't a joke.")
    login_as(author)
    visit "/"
  end
  scenario "for a given project" do
    click_link "Sublime Text 3"
    expect(page).to have_content "Make it shiny!"
    expect(page).to_not have_content "Standards compliance"
    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content "Make it shiny!"
    end
    expect(page).to have_content "Gradients! Starbursts! Oh my!"
  end
end