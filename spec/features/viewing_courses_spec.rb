require "rails_helper"
RSpec.feature "Users can view courses" do
  let(:user) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course, name: "Rails 4") }
  before do
    login_as(user)
    assign_role!(user, :viewer, course)
  end
  scenario "with the course details" do
    visit "/"
    click_link "Rails 4"
    expect(page.current_url).to eq course_url(course)
  end
  scenario "unless they do not have permission" do
    FactoryGirl.create(:course, name: "Hidden")
    visit "/"
    expect(page).not_to have_content "Hidden"
  end
end