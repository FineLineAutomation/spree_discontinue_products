require 'spec_helper'

module Spree
  describe Spree::Product do
    let(:product) { create(:product) }

    before(:each) do
      product.on_hand = 5
    end

    describe "filter proudcts" do
      context "for products not sold" do
        it "should not be displayed" do
          product.is_sold = false
          product.on_display?.should == false
        end

        it "should not be able to be bought" do
          product.is_sold = false
          product.on_sale?.should == false
        end
      end

      context "for products that are sold" do
        it "should be displayed" do
          product.is_sold = true
          product.on_display?.should == true
        end

        it "should be able to be bought" do
          product.is_sold = true
          product.on_sale?.should == true
        end
      end

      context "for discontinued products" do
        it "should not show discontinued products with no inventory" do
          Spree::Config[:show_zero_stock_products] = true
          product.is_sold = true
          product.discontinue_on = 1.day.ago
          product.on_hand = 0
          product.on_display?.should == false
        end

        it "should not allow discontinued products with no inventory to be bought" do
          Spree::Config[:allow_backorders] = true
          product.is_sold = true
          product.discontinue_on = 1.day.ago
          product.on_hand = 0
          product.on_sale?.should == false
        end

        it "should show discontinued products with inventory" do
          product.is_sold = true
          product.discontinue_on = 1.day.ago
          product.on_hand = 5
          product.on_display?.should == true
        end

        it "should allow discontinued products with inventory to be bought" do
          product.is_sold = true
          product.discontinue_on = 1.day.ago
          product.on_hand = 5
          product.on_sale?.should == true
        end
      end
    end
  end
end
