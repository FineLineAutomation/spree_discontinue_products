# Add product packages relation
Spree::Product.class_eval do
  attr_accessible :is_sold, :discontinue_on
  
end