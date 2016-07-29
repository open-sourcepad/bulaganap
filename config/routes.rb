Rails.application.routes.draw do

  constraints format: "json" do
    resources :games do
      collection do
        post 'find_match'
      end
    end

    resources :moves, only: [:create]

    get "*path" => "application#index"
    root to: "application#index"
  end

end
