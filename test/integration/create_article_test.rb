require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "For test", email: "fortest@example.com", password: "foobar", admin: false)
    sign_in_as(@user)
  end

  test "get new article form and create article successfully" do
    get new_article_path
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "New article", description: "New article description" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_match "New article", response.body
  end

  test "get new article form but fail to create article" do
    get new_article_path
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: " ", description: " " } }
    end
    assert_match "following errors", response.body
  end

end