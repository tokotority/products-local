Feature: The Products service back-end
    As a Products Manager
    I need a RESTful catalog service
    So that I can keep track of all my products

Background:
    Given the following products
        | name    | description | price | available | image_url  | category    |
        | iPhone 15  | Best iphone for now  | 999   | True      | sample.url | ELECTRONICS |
        | iPhone 16  | Best iphone for now  | 999   | False      | sample.url | ELECTRONICS |
        | milk    | Oat Milk    | 10    | True      | sample.url | FOOD        |
        | egg     | Organic Egg | 1     | True      | sample.url | FOOD        |

Scenario: The server is running
    When I visit the "Home Page"
    Then I should see "Product REST API Service" in the title
    And I should not see "404 Not Found"

Scenario: Create a Product
    When I visit the "Home Page"
    And I set the "Name" to "Ball"
    And I select "SPORTS" in the "Category" dropdown
    And I set the "Description" to "Basketball"
    And I set the "Price" to "100"
    And I select "True" in the "Available" dropdown
    And I set the "image_url" to "sample.url"
    And I press the "Create" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I press the "Clear" button
    Then the "Id" field should be empty
    And the "Name" field should be empty
    And the "Category" field should be empty
    And the "Description" field should be empty
    And the "Price" field should be empty
    And the "image_url" field should be empty
    When I paste the "Id" field
    And I press the "Retrieve" button
    Then I should see the message "Success"
    And I should see "Ball" in the "Name" field
    And I should see "SPORTS" in the "Category" field
    And I should see "Basketball" in the "Description" field
    And I should see "100" in the "Price" field
    And I should see "True" in the "Available" dropdown
    And I should see "sample.url" in the "image_url" field