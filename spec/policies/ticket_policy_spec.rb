require "rails_helper"
RSpec.describe TicketPolicy do
  context "permissions" do
    subject { TicketPolicy.new(user, ticket) }
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course) }
    let(:ticket) { FactoryGirl.create(:ticket, course: course) }
    context "for anonymous users" do
      let(:user) { nil }
      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end
    context "for viewers of the course" do
      before { assign_role!(user, :viewer, course) }
      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end
    context "for editors of the course" do
      before { assign_role!(user, :editor, course) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      context "when the editor created the ticket" do
        before { ticket.author = user }
        it { should permit_action :update }
      end
    end
    context "for managers of the course" do
      before { assign_role!(user, :manager, course) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end
    context "for managers of other courses" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:course))
      end
      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end
    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end
  end
  end