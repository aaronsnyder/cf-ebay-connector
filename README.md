cf_ebay
=======

ColdFusion Ebay connector

1. obtain an eBay developer account by googling: "ebay developer account"
2. sign up, and verify your account
3. go to the eBay API test tool: https://developer.ebay.com/DevZone/build-test/test-tool/
4. in the left-hand pane under "Select a key set", click to generate a sandbox key set and fill out your application information.
5. under "Select and API", select "trading API" from the dropdown.
6. click "generate user token"
7. create a new eBay user account for use with your devloper application, and generate your key.
8. once created, all required information will be available to use this tool.
9. plug in all eBay auth info into ebay.cfc in getEbayAuthToken function. You will want to store this info in a DB in the long term.
10. navigate to http://#yourdomainname#/#pathtocfc#/ebay.cfc?method=getEbayTime to test.
