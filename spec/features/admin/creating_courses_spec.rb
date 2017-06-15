require "rails_helper"
RSpec.feature "Users can create new courses" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit "/"
    click_link "New Course"
  end
  scenario "with valid attributes" do
    fill_in "Name", with: "Ruby on rails"
    fill_in "Description", with: "A ruby framework"
    click_button "Create Course"
    expect(page).to have_content "Course has been created."
    course = Course.find_by(name: "Ruby on rails")
    expect(page.current_url).to eq course_url(course)
    title = "Ruby on rails - Courses - Titan"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Course"
    expect(page).to have_content "Course has not been created."
    expect(page).to have_content "Name can't be blank"
  end

end