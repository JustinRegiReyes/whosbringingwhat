class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :username
      t.text :comment_notifications, array: true, default: []
      t.text :invitation_notifications, array: true, default: []
      t.text :invitations, array: true, default: []

      t.timestamps null: false
    end
  end
end
