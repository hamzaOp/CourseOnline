require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  it "handles a missing ticket correctly" do
    sublime = FactoryGirl.create(:course, name: "Sublime Text 3")
    get :show, id: "not here" , course_id: sublime.id
    expect(response).to redirect_to(course_path(sublime))
    message = "The ticket you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end
