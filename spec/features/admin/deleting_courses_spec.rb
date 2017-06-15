require "rails_helper"
RSpec.feature "Users can delete courses" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
  end
  scenario "successfully" do
    FactoryGirl.create(:course, name: "Rails 4")
    visit "/"
    click_link "Rails 4"
    click_link "Delete Course"
    expect(page).to have_content "Course has been deleted."
    expect(page.current_url).to eq courses_url
    expect(page).to have_no_content "Rails 4"
  end
end