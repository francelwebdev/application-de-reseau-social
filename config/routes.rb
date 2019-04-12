Rails.application.routes.draw do
            # , path: "user", path_names: {sign_in: "login", sign_out: "logout", sign_up: "registrer"}, registrations: "users/registrations", sessions: "users/sessions"
    scope "/(:locale)", locale: /fr/ do
        root to: "pages#landing_page"
        devise_for :users
        get "fr", to: redirect("pages#landing_page")
        resources :friendships
        namespace :account do
            resources :my_questions
            resources :my_friends
        end
        resources :questions do
            resources :answers
        end
        scope '/account' do
          # devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "registrer"}, skip: :omniauth_callbacks
      end
      resources :users, only: [:index, :show] do
        member do
            put "like", to: "users#like"
            put "dislike", to: "users#dislike"
        end
    end
end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
