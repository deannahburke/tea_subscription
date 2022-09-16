# :teapot: Tea Subscription API :teapot:
<!-- TABLE OF CONTENTS -->
  <details>
  <summary>Table of Contents</summary>
  <ol>
    </li>
    <li><a href="#teapot-project-overview">Project Overview</a></li>
    <li><a href="#teapot-tech--tools">Tech &amp; Tools</a></li>
    <li><a href="#teapot-schema">Schema</a></li>
    <li><a href="#teapot-api-endpoints">API Endpoints</a></li>
    <li><a href="#teapot-local-setup">Local Setup</a></li>
  </ol>
</details>

<!-- PROJECT OVERVIEW -->
## :teapot: Project Overview
A Rails RESTful API project built to create, update, and delete fictional tea subscriptions for customers :tea:

<!-- Tech &amp; Tools -->
## :teapot: Tech &amp; Tools
[<img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"/>](https://www.ruby-lang.org/en/) **Version 2.7.4**<br>
[<img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>](https://rubyonrails.org/) **Version 7.0.4**<br>
<img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white"/><br>
[<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/>](https://www.postman.com/product/what-is-postman/)<br>

<!-- SCHEMA -->
## :teapot: Schema
![Screen Shot 2022-09-15 at 5 23 27 PM](https://user-images.githubusercontent.com/98491210/190527754-2d91274e-5887-4e90-8649-8ff8e97ad846.png)

<!-- API ENDPOINTS -->
## :teapot: API Endpoints
### Happy Path Endpoint Use
Create a new subscription for an exising customer using their ID.  Tea ID must also be sent in the request body:<br>
<br>:tea: `POST /api/v1/customers/#{customer.id}/subscriptions`<br>
<br>Example response:
```ruby
    "data": {
        "type": "subscriptions",
        "id": 5,
        "attributes": {
            "title": "Weekly Green",
            "price": 25.5,
            "status": "active",
            "frequency": "weekly"
        }
...
```
Cancel a customer's existing subscription:<br>
<br>:tea: `PATCH /api/v1/customers/#{customer.id}/subscriptions`<br>
<br>Example response:
```ruby
    "data": {
        "type": "subscriptions",
        "id": 1,
        "attributes": {
            "title": "Weekly Green",
            "price": 25.5,
            "status": "cancelled",
            "frequency": "weekly"
        }
...
```
Get all subscriptions, both active and cancelled, for a customer:<br>
<br>:tea: `GET /api/v1/customers/#{customer.id}/subscriptions`<br>
<br>Example response:
```ruby
    "data": {
        "type": "customers",
        "id": 1,
        "attributes": {
            "first_name": "Deannah",
            "last_name": "Burke",
            "email": "dmb@gmail.com",
            "address": "123 Bryant Street Denver CO 80211",
            "subscriptions": [
                {
                    "title": "Weekly Green",
                    "price": 25.5,
                    "status": "active",
                    "frequency": "weekly"
                },
                {
                    "title": "Monthly Chamomile",
                    "price": 41.75,
                    "status": "cancelled",
                    "frequency": "monthly"
                },
                {
                    "title": "Weekly Chai",
                    "price": 21.6,
                    "status": "active",
                    "frequency": "weekly"
                }
            ]
        }
...
```
### Sad Path/Errors
If params are missing in the create subscription request body, the response will return an error.  For example, if price is not sent:<br>
```ruby
    "error": "Price can't be blank"
```
If updating or cancelling a subscription without a valid subscription ID:<br>
```ruby
    "error": "Cannot find subscription without ID"
```
If getting all subscriptions for a customer without a valid customer ID:<br>
```ruby
    "error": "Invalid customer ID"
```
If the customer's ID is valid but they do not yet have any subscriptions:<br>
```ruby
    "message": "This customer has no subscriptions"
```
<!-- LOCAL SETUP -->
## :teapot: Local Setup
1. Check your versions of Ruby and Rails by running these commands in your command line:
`ruby -v`
`rails -v`
2. Fork and clone this repo to your local machine with SSH: `git@github.com:deannahburke/tea_subscription.git`
3. Install gems and dependencies: `bundle install`
4. Set up local database: `rails db:{drop,create,migrate,seed}
5. Run test suite locally: `bundle exec rspec`
6. Start your server: `rails s`
7. Visit the endpoint url: `http://localhost:3000/api/v1/customers/:customer_id/subscriptions` to consume the API on your local machine. 
