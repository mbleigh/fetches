require 'test/unit'
require 'rubygems'
require 'activesupport'

require "#{File.dirname(__FILE__)}/../lib/action_controller/fetches"
require "#{File.dirname(__FILE__)}/fetcher_test_helper"

class FetchesTest < Test::Unit::TestCase
  
  def test_basics
    controller = Class.new(FakeController) do
      include ActionController::Fetches
      fetches :fetch_test_model
    end.new
    
    assert controller.respond_to?(:fetch_test_model)
    
    controller.params = {:id => 1}
    assert_equal "one worked", controller.fetch_test_model
    controller.params = {:id => 2}
    assert_equal "two worked", controller.fetch_test_model
    controller.params = {:id => 3}
    assert_throws(Exception)
  end
end
