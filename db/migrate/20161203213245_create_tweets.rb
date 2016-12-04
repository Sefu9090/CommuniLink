class CreateTweets < ActiveRecord::Migration
  def change
      t.string :status
      t.string :user_id
  end
end
