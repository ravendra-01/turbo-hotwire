Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'posts#index'
  
  get 'member/:id', to: 'members#show', as: 'member'
  get 'edit_description', to: 'members#edit_description', as: 'edit_member_description'
  patch 'update_description', to: 'members#update_description', as: 'update_member_description'
  get 'edit_personal_details', to: 'members#edit_personal_details', as: 'edit_member_personal_details'
  patch 'update_personal_details', to: 'members#update_personal_details', as: 'update_member_personal_details'
  get 'member-connections/:id', to: 'members#connections', as: 'member_connections'
  get 'home/index', to: 'home#index', as: 'search_professionals'
  post 'post/like', to: 'likes#like'
  post 'post/dislike', to: 'likes#dislike'
  resources :work_experiences
  resources :connections
  resources :posts
end
