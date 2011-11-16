ActiveAdminLeaks::Application.routes.draw do
  root to: 'application#home'

  devise_for :admin_users
end
