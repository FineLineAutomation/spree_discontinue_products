spree_discontinue_products
==========================

[![Build
Status](https://secure.travis-ci.org/FineLineAutomation/spree_discontinue_products.png)](http://travis-ci.org/FineLineAutomation/spree_discontinue_products)

A spree extension that adds is sold and discontinue options to products.

* Is Sold checkbox available on the product general page
	* If it's not checked, a product will NOT show up in the products list, searches, taxon lists, or directly.
	* Useful for:
		* BOM items that you need for assembly of actual sellable items.
		* New items you don't want to list yet.
		* Seasonal Items that you only stock once in a while.
* Discontinue on date field avialbe on the product general page
	* If you set a date, the product will be discontinued on that date.
	* The website will display discontinued products that have inventory until they sell out of inventory at which point the products will be hidden.
	* Useful for:
		* Scratch and dent products
		* Overstock
		* Older versions of a product that
		* Clearance items

Installation
------------

If you are installing this on an actual production store, we recommend that you pull from the stable branch of your spree version (i.e. If you are running 1.3.X, pull from 1-3-stable)

1. Add the following to your applications Gemfile:

    a. To use the latest edge code in master branch:

    ```ruby
    gem 'spree_discontinue_products', :git => "git://github.com/FineLineAutomation/spree_discontinue_products"
    ```

    b. To use a specific branch specified in the Versionfile for your version of Spree:

    ```ruby
    gem 'spree_discontinue_products', :git => "git://github.com/FineLineAutomation/spree_discontinue_products", :branch => '1-3-stable'
    ```

2. Run bundler:

```
$ bundle
```

3. Run Install Script:

```
$ bundle exec rails g spree_discontinue_products:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2013 Fine Line Automation, released under the New BSD License
