class CreateUserCommentVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_comment_votes do |t|
      t.boolean :upvote
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
