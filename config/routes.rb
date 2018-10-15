Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, constraints: { format: :json }, defaults: { format: :json } do
    namespace :v1 do
      resources :tasks, except: :edit
      resources :tags,  except: %i[show edit]
    end
  end
end
