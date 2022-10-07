# Albums Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE user_accounts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO users (email_address, username) VALUES ('harry_styles@email.com', 'harry_styles');
INSERT INTO users (email_address, username) VALUES ('taylor_swift@email.com', 'taylor_swift');
INSERT INTO posts (title, content, views, user_id) VALUES ('Harrys House', 'SONGSSSS', '5000', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Watermelon Sugar', 'Tastes like strawberries', '600', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('You Belong With Me', 'Youre on the phone', '300', '2');
INSERT INTO posts (title, content, views, user_id) VALUES ('Red', 'Losing you was blue', '400', '2');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class UserAccount
end

# Repository class
# (in lib/student_repository.rb)
class UserAccountRepository
end
```

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Post
end

# Repository class
# (in lib/student_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class UserAccount

  # Replace the attributes by your own columns.
  attr_accessor :id, :email_address, :username
end

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_account_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all user_accounts

repo = UserAccountRepository.new

user_accounts = repo.all
user_accounts.length # => 2
user_accounts.first.id # => '1'
user_accounts.first.email_address # => 'harry_styles@email.com'
user_accounts.first.username # => 'harry_styles'

# 2
# Get a specific user_account
repo = UserAccountRepository.new

user_account = repo.find(1)
user_account.email_address # => 'harry_styles@email.com'
user_account.username # => 'harry_styles'

# 3
# Add an user_account
repo = UserAccountRepository.new

user_account = UserAccount.new
user_account.email_address = 'billie_eilish@email.com'
user_account.username = 'billie_eilish'

repo.create(user_account)

user_accounts = repo.all
user_accounts.length # => 3
user_accounts.last.id # => '3'
user_accounts.last.email_address # => billie_eilish@email.com'
user_accounts.last.username # => billie_eilish'

# 4
# Delete a user_account
repo = UserAccountRepository.new

id = 1

repo.delete(id)

user_accounts = repo.all

user_accounts.length # => 1
user_accounts.first.id # => '2'

# 5
# Update a user_account
repo = UserAccountRepository.new

user_account = repo.find(1)

user_account.email_address = 'new_email_address'
user_account.username = 'new_username'

repo.update(user_account)

updated_user_account = repo.find(1)

updated_user_account.email_address # => 'new_email_address'
updated_user_account.username # => 'new_username'

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all
posts.length # => 4
posts.first.id # => '1'
posts.first.title # => 'Harrys House'
posts.first.content # => 'SONGSSSS'
posts.first.views # => '5000'
posts.first.user_account_id # => '1'

# 2
# Get a specific post
repo = PostRepository.new

post = repo.find(1)
post.title # => 'Harrys House'
post.content # => 'SONGSSSS'
post.views # => '5000'
post.user_account_id # => '1'

# 3
# Add a post
repo = PostRepository.new

post = Post.new
post.title = 'All Too Well'
post.content = '10 minute version'
post.views = '300'
post.user_account_id = '2'

repo.create(post)

posts = repo.all
posts.length # => 5
posts.last.id # => '5'
posts.last.title # => 'All Too Well'
posts.last.content # => '10 minute version'
posts.last.views # => '300'
posts.last.user_account_id # => '2'

# 4
# Delete a user_account
repo = PostRepository.new

id = 1

repo.delete(id)

post = repo.all

post.length # => 1
post.first.id # => '2'

# 5
# Update a user_account
repo = PostRepository.new

post = repo.find(1)

post.title = 'new_title'
post.content = 'new_content'
post.views = '300'
post.user_account_id = '2'

repo.update(post)

updated_post = repo.find(1)

updated_post.title # => 'new_title'
updated_post.content # => 'new_content'
updated_post.views # => '300'
updated_post.content # => '2'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
