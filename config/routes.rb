Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
 # delete 'logout' => '#destroy' 
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



#[:hello, :world] == %i{hello world} 둘이 같은 거임 루비에서 저절로 나눠줌