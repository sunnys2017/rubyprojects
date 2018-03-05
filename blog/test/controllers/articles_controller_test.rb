require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: "test_title", text: "test_text" } }
    end

    assert_redirected_to article_url(Article.last)
    assert_equal 'Article was successfully created.', flash[:notice]
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { title: "test_title" } }
    assert_redirected_to article_url(@article)

    @article.reload
    assert_equal "test_title", @article.title
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test "should create route articles index" do
    assert_generates '/articles', controller: 'articles', action: 'index'
  end

  test "should create route articles new" do
    assert_generates '/articles/new', controller: 'articles', action: 'new'
  end

  test "ajax request" do
    article = articles(:one)
    get article_url(article), xhr: true
 
    #assert_equal 'hello world', @response.body
    assert_equal "text/html", @response.content_type
  end

end
