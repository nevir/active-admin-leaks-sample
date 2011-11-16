class CreateDefaultAdminUser < ActiveRecord::Migration
  def up
    AdminUser.create(email: 'admin@admin.com', password: '123456', password_confirmation: '123456')
  end

  def down
    AdminUser.where(email: 'admin@admin.com').destroy
  end
end
