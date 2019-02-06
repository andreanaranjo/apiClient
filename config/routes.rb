Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ratings
  scope '/api'do
    get '/ratings.json' => 'ratings#index'
    post '/ratings.json' => 'ratings#create'
    scope '/ratings' do
      get '/:id/edit.json' => 'ratings#edit'
      get '/:id/show.json'=> 'ratings#show'
      patch '/:id/update.json' => 'ratings#update'
      delete '/:id/destroy.json'=> 'ratings#destroy'
    end
  end
  root "ratings#index"
end
