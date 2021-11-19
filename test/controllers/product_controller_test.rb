require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get product_name:string_url
    assert_response :success
  end

  test "should get processor:string" do
    get product_processor:string_url
    assert_response :success
  end

  test "should get operating_system" do
    get product_operating_system_url
    assert_response :success
  end

  test "should get memory:string" do
    get product_memory:string_url
    assert_response :success
  end

  test "should get storage:string" do
    get product_storage:string_url
    assert_response :success
  end

  test "should get display:string" do
    get product_display:string_url
    assert_response :success
  end

  test "should get price:integer" do
    get product_price:integer_url
    assert_response :success
  end

end
