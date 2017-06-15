require "rails_helper"
RSpec.feature "Course managers can edit existing courses" do
  let(:user) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course, name: "Rails 4") }
  before do
    login_as(user)
    assign_role!(user, :manager, course)
    visit "/"
    click_link "Rails 4"
    click_link "Edit Course"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Rails 5"
    click_button "Update Course"
    expect(page).to have_content "Course has been updated."
    expect(page).to have_content "Rails 5"
  end

  scenario "when providing invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Course"
    expect(page).to have_content "Course has not been updated."
  end
  end