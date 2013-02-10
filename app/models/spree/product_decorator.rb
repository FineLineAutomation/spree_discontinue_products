# Add product packages relation
Spree::Product.class_eval do
  attr_accessible :is_sold, :discontinue_on

  # should product be displayed on products pages and search
  def on_display?
    is_sold && ( !discontinued? || has_stock? ) && ( has_stock? || Spree::Config[:show_zero_stock_products] )
  end

  def discontinued?
    !( discontinue_on.nil? || discontinue_on.future? )
  end

  # is this product actually available for purchase
  def on_sale?
    is_sold && ( !discontinued? || has_stock? ) && ( has_stock? || Spree::Config[:allow_backorders] )
  end

end