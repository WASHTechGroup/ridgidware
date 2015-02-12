require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Student Role Exists" do
  	assert_not_nil(Role.find_by({name: 'Student'})) 
  end

  test "Admin Role Exists" do
  	assert_not_nil(Role.find_by({name: 'Admin'})) 
  end

  test "Manager Role Exists" do
  	assert_not_nil(Role.find_by({name: 'Manager'})) 
  end

  test "Staff Role Exists" do
  	assert_not_nil(Role.find_by({name: 'Staff'})) 
  end
end
