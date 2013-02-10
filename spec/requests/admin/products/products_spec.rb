require 'spec_helper'

describe "Products" do
  stub_authorization!

  context "as admin user" do
    before(:each) do
      visit spree.admin_path
    end

    context 'updating a product', :js => true do
      let(:product) { create(:product) }

      it 'should allow is sold field to be updated' do
        visit spree.admin_product_path(product)
        find(:css, "#product_is_sold").should_not be_checked
        find(:css, "#product_is_sold").set(true)
        click_button "Update"
        page.should have_content("successfully updated!")
        Spree::Product.last.is_sold.should == true
      end
    end

  end
end