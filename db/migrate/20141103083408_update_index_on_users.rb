class UpdateIndexOnUsers < ActiveRecord::Migration
  def change
    sql = 'DROP INDEX index_users_on_email'
    sql << ' ON users' if Rails.env == 'production' # Heroku pg
    ActiveRecord::Base.connection.execute(sql)
  end
end
