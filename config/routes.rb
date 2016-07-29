Rails.application.routes.draw do

  resources :games do
    collection do
      post 'find_match'
    end
  end
  
end
