require 'spec_helper'

describe Spree::ProductsController do
  let!(:product) { create(:product, :available_on => 1.day.ago, :is_sold => true) }
  let!(:not_sold_product) { create(:product, :available_on => 1.day.ago, :is_sold => false) }
  let!(:discontinued_product_1) { create(:product, :available_on => 2.days.ago, :is_sold => true, :discontinue_on => 1.day.ago) }
  let!(:discontinued_product_2) { create(:product, :available_on => 2.days.ago, :is_sold => true, :discontinue_on => 1.day.ago) }

  it "allows admins to view non-sold products" do
    controller.stub :spree_current_user => stub(:has_spree_role? => true, :last_incomplete_spree_order => nil)
    spree_get :show, :id => not_sold_product.to_param
    response.status.should == 200
  end

  it "allows admins to view discontinued products" do
    discontinued_product_1.on_hand = 0
    controller.stub :spree_current_user => stub(:has_spree_role? => true, :last_incomplete_spree_order => nil)
    spree_get :show, :id => discontinued_product_1.to_param
    response.status.should == 200
  end

  it "allows admins to view discontinued products" do
    discontinued_product_2.on_hand = 5
    controller.stub :spree_current_user => stub(:has_spree_role? => true, :last_incomplete_spree_order => nil)
    spree_get :show, :id => discontinued_product_2.to_param
    response.status.should == 200
  end

  it "cannot view non-sold products" do
    controller.stub :spree_current_user => stub(:has_spree_role? => false, :last_incomplete_spree_order => nil)
    spree_get :show, :id => not_sold_product.to_param
    response.status.should == 404
  end

  it "cannot view discontinued products with no inventory" do
    Spree::Config[:show_zero_stock_products] = true
    discontinued_product_1.on_hand = 0
    controller.stub :spree_current_user => stub(:has_spree_role? => false, :last_incomplete_spree_order => nil)
    spree_get :show, :id => discontinued_product_1.to_param
    response.status.should == 404
  end

  it "can view products discontinued in future" do
    discontinued_product_1.discontinue_on = 3.days.from_now
    discontinued_product_1.on_hand = 5
    discontinued_product_1.save
    controller.stub :spree_current_user => stub(:has_spree_role? => false, :last_incomplete_spree_order => nil)
    spree_get :show, :id => discontinued_product_1.to_param
    response.status.should == 200
  end

  it "can view discontinued products wtih inventory" do
    discontinued_product_2.on_hand = 5
    discontinued_product_2.save
    controller.stub :spree_current_user => stub(:has_spree_role? => false, :last_incomplete_spree_order => nil)
    spree_get :show, :id => discontinued_product_2.to_param
    response.status.should == 200
  end
end
