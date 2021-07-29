class SignupUserTest < ActionDispatch::IntegrationTest

  test "successfully signup as new user" do
    get signup_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { username: "New user", email: "example@example.com", password: "foobar" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_match "New user", response.body
  end

  test "fail to signup as new user" do
    get signup_path
    assert_response :success
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { username: " ", email: " ", password: " " } }
    end
    assert_match "following errors", response.body
  end

end