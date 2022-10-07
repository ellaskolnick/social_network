require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "lists all the posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 4
    expect(posts.first.id).to eq '1'
    expect(posts.first.title).to eq 'Harrys House'
    expect(posts.first.content).to eq 'SONGSSSS'
    expect(posts.first.views).to eq '5000'
    expect(posts.first.user_account_id).to eq '1'
  end

  it "gets a specific post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.title).to eq 'Harrys House'
    expect(post.content).to eq 'SONGSSSS'
    expect(post.views).to eq '5000'
    expect(post.user_account_id).to eq '1'
  end

  it "adds a post" do
    repo = PostRepository.new

    post = Post.new
    post.title = 'All Too Well'
    post.content = '10 minute version'
    post.views = '300'
    post.user_account_id = '2'

    repo.create(post)

    posts = repo.all

    expect(posts).to include(
      have_attributes(
        title: post.title,
        content: post.content,
        views: post.views,
        user_account_id: post.user_account_id
      )
    )
  end

  it "deletes a post" do
    repo = PostRepository.new

    id = 1

    repo.delete(id)

    post = repo.all

    expect(post.length).to eq 3
    expect(post.first.id).to eq '2'
  end

  it "updates a user_account" do
    repo = PostRepository.new

    post = repo.find(1)

    post.title = 'new_title'
    post.content = 'new_content'
    post.views = '300'
    post.user_account_id = '2'

    repo.update(post)

    updated_post = repo.find(1)

    expect(updated_post.title).to eq 'new_title'
    expect(updated_post.content).to eq 'new_content'
    expect(updated_post.views).to eq '300'
    expect(updated_post.user_account_id).to eq '2'
  end
end
