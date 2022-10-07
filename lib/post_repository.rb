require 'post'

class PostRepository

  def all
    sql = 'SELECT * FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.user_account_id = record['user_account_id']
      posts << post
    end

    posts
  end

  def find(id)
    sql = 'SELECT * FROM posts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.user_account_id = record['user_account_id']

    post
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, views, user_account_id) VALUES ($1, $2, $3, $4);'
    sql_params = [post.title, post.content, post.views, post.user_account_id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def update(post)
    sql = 'UPDATE posts SET title = $1, content = $2, views = $3, user_account_id = $4 WHERE id = $5;'
    sql_params = [post.title, post.content, post.views, post.user_account_id, post.id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)
  end
end
