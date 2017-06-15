require "rails_helper"

describe AttachmentPolicy do


  context "permissions" do
    subject { AttachmentPolicy.new(user, attachment) }
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course) }
    let(:ticket) { FactoryGirl.create(:ticket, course: course) }
    let(:attachment) { FactoryGirl.create(:attachment, ticket: ticket) }
    context "for anonymous users" do
      let(:user) { nil }
      it { should_not permit_action :show }
    end
    context "for viewers of the course" do
      before { assign_role!(user, :viewer, course) }
      it { should permit_action :show }
    end
    context "for editors of the course" do
      before { assign_role!(user, :editor, course) }
      it { should permit_action :show }
    end
    context "for managers of the course" do
      before { assign_role!(user, :manager, course) }
      it { should permit_action :show }
    end
    context "for managers of other courses" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:course))
      end
      it { should_not permit_action :show }
      context "for administrators" do
        let(:user) { FactoryGirl.create :user, :admin }
        it { should permit_action :show }
      end
    end
  end
  end