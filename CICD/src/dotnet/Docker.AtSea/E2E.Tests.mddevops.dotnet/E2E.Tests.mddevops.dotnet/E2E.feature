Feature: E2E
	As Docker Store uers
	I want to see a Home pag eof Docker store
	So that i can select my desired products

Scenario: Visit Docker Art Store
	Given I navigate to the home page at "http://atseaapp.mddevops.test/"
	When I see the home page
	Then the homepage should contain JS file "/Content/static/js/main.7416479b.js"
