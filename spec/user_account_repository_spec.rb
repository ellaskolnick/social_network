require 'user_account_repository'

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do

  before(:each) do
    reset_user_accounts_table
  end

  it "lists all the user_accounts" do
    repo = UserAccountRepository.new

    user_accounts = repo.all

    expect(user_accounts.length).to eq 2
    expect(user_accounts.first.id).to eq '1'
    expect(user_accounts.first.email_address).to eq 'harry_styles@email.com'
    expect(user_accounts.first.username).to eq 'harry_styles'
  end

  it "gets a specific user_account" do
    repo = UserAccountRepository.new

    user_account = repo.find(1)

    expect(user_account.email_address).to eq 'harry_styles@email.com'
    expect(user_account.username).to eq 'harry_styles'
  end

  it "adds a new user_account" do
    repo = UserAccountRepository.new

    user_account = UserAccount.new
    user_account.email_address = 'billie_eilish@email.com'
    user_account.username = 'billie_eilish'

    repo.create(user_account)

    user_accounts = repo.all

    expect(user_accounts).to include(
      have_attributes(
        email_address: user_account.email_address,
        username: user_account.username
      )
    )
  end

  it "deletes a user_account" do
    repo = UserAccountRepository.new

    id = 1

    repo.delete(id)

    user_accounts = repo.all

    expect(user_accounts.length).to eq 1
    expect(user_accounts.first.id).to eq '2'
  end

  it "updates a user_account" do
    repo = UserAccountRepository.new

    user_account = repo.find(1)

    user_account.email_address = 'new_email_address'
    user_account.username = 'new_username'

    repo.update(user_account)

    updated_user_account = repo.find(1)

    expect(updated_user_account.email_address).to eq 'new_email_address'
    expect(updated_user_account.username).to eq 'new_username'
  end
end
