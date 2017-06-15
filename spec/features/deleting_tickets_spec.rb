require "rails_helper"
RSpec.feature "Users can delete tickets" do
  let(:author) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course) }
  let(:ticket) { FactoryGirl.create(:ticket, course: course, author:author) }
  before do
    login_as(author)
    assign_role!(author, :manager, course)
    visit course_ticket_path(course, ticket)
  end
  scenario "successfully" do
    click_link "Delete Ticket"
    expect(page).to have_content "Ticket has been deleted."
    expect(page.current_url).to eq course_url(course)
  end
end