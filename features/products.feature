Feature: The Products service back-end
    As a Products Manager
    I need a RESTful catalog service
    So that I can keep track of all my products

Background:
    Given the following products
        | name    | description | price | available | image_url  | category    |
        | iPhone  | iPhone 14   | 999   | True      | sample.url | ELECTRONICS |
        | iPhone  | iPhone 15   | 999   | True      | sample.url | ELECTRONICS |
        | iPhone  | iPhone 16   | 999   | False     | sample.url | ELECTRONICS |
        | milk    | Oat Milk    | 10    | True      | sample.url | FOOD        |
        | egg     | Organic Egg | 1     | True      | sample.url | FOOD        |

Scenario: The server is running
    When I visit the "Home Page"
    Then I should see "Product REST API Service"
    And I should not see "404 Not Found"
