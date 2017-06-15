require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  it "handles a missing course correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(courses_path)
    message = "The course you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
  it "handles permission errors by redirecting to a safe place" do
    allow(controller).to receive(:current_user)
    course = FactoryGirl.create(:course)
    get :show, id: course
    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
