require_relative "../../test_helper"
require_relative "flow_test_helper"

require "smart_answer_flows/additional-commodity-code"

class AdditionalCommodityCodeTest < ActiveSupport::TestCase
  include FlowTestHelper

  setup do
    setup_for_testing_flow SmartAnswer::AdditionalCommodityCodeFlow
  end
  ## Q1
  should "ask how much starch glucose the product contains" do
    assert_current_node :how_much_starch_glucose?
  end

  context "answer 25" do
    ## Q2c
    should "ask how much sucrose the product contains" do
      add_response 25
      assert_state_variable "starch_glucose_weight", "25"
      assert_current_node :how_much_sucrose_2?
    end
  end
  context "answer 50" do
    ## Q2d
    should "ask how much sucrose the product contains" do
      add_response 50
      assert_state_variable "starch_glucose_weight", "50"
      assert_current_node :how_much_sucrose_3?
    end
  end
  context "answer 75" do
    ## Q2e
    should "ask how much sucrose the product contains" do
      add_response 75
      assert_state_variable "starch_glucose_weight", "75"
      assert_current_node :how_much_sucrose_4?
    end
  end
  context "answer 5" do
    setup do
      add_response 5
    end
    ## Q2ab
    should "ask how much sucrose the product contains" do
      assert_state_variable "starch_glucose_weight", "5"
      assert_current_node :how_much_sucrose_1?
    end
    context "answer 30" do
      setup do
        add_response 30
      end
      ## Q3
      should "save the input" do
        assert_state_variable "sucrose_weight", "30"
      end
      should "ask how much milk fat the product contains" do
        assert_current_node :how_much_milk_fat?
      end
      context "answer 0" do
        should "ask how much milk protein the product contains" do
          add_response 0
          assert_current_node :how_much_milk_protein_ab?
        end
      end
      context "answer 9" do
        should "ask how much milk protein the product contains" do
          add_response 9
          assert_current_node :how_much_milk_protein_ef?
        end
      end
      context "answer 18" do
        should "ask how much milk protein the product contains" do
          add_response 18
          assert_current_node :how_much_milk_protein_gh?
        end
      end
      context "answer 3" do
        setup do
          add_response 3
        end
        ## Q3c
        should "ask how much milk protein the product contains" do
          assert_current_node :how_much_milk_protein_c?
        end
      end
    end
  end
end
