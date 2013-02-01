Feature: Manage Products
		In order to manage products
		As a store manager
		I want to be able to mark products as not sold
	
	Scenario: Mark Product As Not Sold
		Given I have products titled Cup, Shirt
		And I am on the list of products
		When I follow "Cup"
		And I fill in "Is Sold" with false
		and I press "Update"
		Then I should see "Product Updated."