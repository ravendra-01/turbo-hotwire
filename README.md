## About

This is a developer community project, where we can search profiles of other developers and send connection requests. And we can check the received requests inside 'My Network' page, where we can accept or reject that request. Also we can check mutual connections.

#### Prerequisites

- ruby 3.2.2
- rails 7.0.8
- Node 18+, and Yarn 1.x

#### Install

##### 1. Check out the repository

```bash
git clone https://github.com/ravendra-01/turbo-hotwire.git
```

##### 2. Create and setup the database

Run the following commands to install gems.

```ruby
bundle install
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create db:migrate db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000

#### Features

- Implemented authentication using devise.
- Used Bootstrap for styling.
- Used Turbo Stream and Stimulus Controller.
