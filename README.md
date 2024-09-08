
# Discography Project

This is a discography project that allows managing artists, LPs, songs, and authors. The application is built using Ruby on Rails and follows a MVC structure.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

- **Ruby**: Version 3.x.x or higher
- **Rails**: Version 6.x.x or higher
- **Bundler**: Version 2.x.x or higher
- **SQLite3**: (The default database for this project)
- **Git**: To clone the repository

### Installation and Setup

Follow these steps to install and set up the project:

### 1. Clone the repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/Palaskan/Discography-project
cd discography-project
```

### 2. Install dependencies

Once inside the project directory, run the following command to install all the necessary gems:

```bash
bundle install
```

### 3. Set up the database

This project uses SQLite3 as the default database. To set up and create the database, run the following commands:

```bash
rails db:migrate
```
This will create the database and run all the migrations.

Load the data from seeds.rb using:

```bash
rails db:seed
```

### 4. Run the application

To start the Rails server, run:

```bash
rails server
```

This will start the server at `http://localhost:3000`. You can now open your browser and access the application at that address.

### 5. Run tests

This project has tests implemented using RSpec. To run the tests, use the following command:

```bash
rspec
```
