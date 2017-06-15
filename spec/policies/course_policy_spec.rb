require "rails_helper"

describe CoursePolicy do

  let(:user) { User.new }

  subject { CoursePolicy }

  context "policy_scope" do
    subject { Pundit.policy_scope(user, Course) }
    let!(:course) { FactoryGirl.create :course }
    let(:user) { FactoryGirl.create :user }
    it "is empty for anonymous users" do
      expect(Pundit.policy_scope(nil, Course)).to be_empty
    end
    it "includes courses a user is allowed to view" do
      assign_role!(user, :viewer, course)
      expect(subject).to include(course)
    end
    it "doesn't include courses a user is not allowed to view" do
      expect(subject).to be_empty
    end
    it "returns all courses for admins" do
      user.admin = true
      expect(subject).to include(course)
    end
  end

  context "permissions" do
    subject { CoursePolicy.new(user, course) }
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course) }
    context "for anonymous users" do
      let(:user) { nil }
      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end
    context "for viewers of the course" do
      before { assign_role!(user, :viewer, course) }
      it { should permit_action :show }
      it { should_not permit_action :update }
    end
    context "for editors of the course" do
      before { assign_role!(user, :editor, course) }
      it { should permit_action :show }
      it { should_not permit_action :update }
    end
    context "for managers of the course" do
      before { assign_role!(user, :manager, course) }
      it { should permit_action :show }
      it { should permit_action :update }
    end
    context "for managers of other courses" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:course))
      end
      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end
    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }
      it { should permit_action :show }
      it { should permit_action :update }
    end
    end



end
