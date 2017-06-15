require "rails_helper"
RSpec.feature "Users can only see the appropriate links" do
  let(:course) { FactoryGirl.create(:course) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:ticket) do
    FactoryGirl.create(:ticket, course: course, author: user)
  end

  context "non-admin users (course viewers)" do
    before do
      login_as(user)
      assign_role!(user, :viewer, course)
    end
    scenario "cannot see the New Course link" do
      visit "/"
      expect(page).not_to have_link "New Course"
    end
    scenario "cannot see the Delete Course link" do
      visit course_path(course)
      expect(page).not_to have_link "Delete Course"
    end
    scenario "cannot see the Edit Course link" do
      visit course_path(course)
      expect(page).not_to have_link "Edit Course"
    end
    scenario "cannot see the New Ticket link" do
      visit course_path(course)
      expect(page).not_to have_link "New Ticket"
    end
    scenario "cannot see the Edit Ticket link" do
      visit course_ticket_path(course, ticket)
      expect(page).not_to have_link "Edit Ticket"
    end
    scenario "cannot see the Delete Ticket link" do
      visit course_ticket_path(course, ticket)
      expect(page).not_to have_link "Delete Ticket"
    end
  end
  context "admin users" do
    before { login_as(admin) }
    scenario "can see the New Course link" do
      visit "/"
      expect(page).to have_link "New Course"
    end
    scenario "can see the Delete Course link" do
      visit course_path(course)
      expect(page).to have_link "Delete Course"
    end
    scenario "can see the Edit Course link" do
      visit course_path(course)
      expect(page).to have_link "Edit Course"
    end
    scenario "can see the New Ticket link" do
      visit course_path(course)
      expect(page).to have_link "New Ticket"
    end
    scenario "can see the Edit Ticket link" do
      visit course_ticket_path(course, ticket)
      expect(page).to have_link "Edit Ticket"
    end
    scenario "can see the Delete Ticket link" do
      visit course_ticket_path(course, ticket)
      expect(page).to have_link "Delete Ticket"
    end
  end
end