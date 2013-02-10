Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "add_discontinue_product_admin_settings",
                     :insert_top => "div[data-hook='admin_product_form_additional_fields']",
                     :partial => "spree/admin/products/discontinue_form_fields")
