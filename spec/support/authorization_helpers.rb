module AuthorizationHelpers
  def assign_role!(user, role, course)
    Role.where(user: user, course: course).delete_all
    Role.create!(user: user, role: role, course: course)
  end
end
RSpec.configure do |c|
  c.include AuthorizationHelpers
end