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

  # Can't use add_search_scope for this as it needs a default argument
  def self.available(available_on = nil)
    variants_table = Spree::Variant.table_name
    available_scope = where("#{Spree::Product.quoted_table_name}.available_on <= ?", available_on || Time.now)
    available_scope = available_scope.where(:is_sold => true)
    available_scope.where("#{Spree::Product.quoted_table_name}.discontinue_on is null
                          OR #{Spree::Product.quoted_table_name}.discontinue_on > ?
                          OR
                          (
                            #{Spree::Product.quoted_table_name}.discontinue_on < ? AND
                            #{table_name}.id in (
                              select product_id from #{variants_table}
                              where product_id = #{table_name}.id and #{variants_table}.deleted_at IS NULL
                              group by product_id
                              having sum(count_on_hand) > 0
                            )
                          )", available_on || Time.now, available_on || Time.now)
  end
  search_scopes << :available

end