Rails.application.routes.draw do


  #USERS
  get '/', to: 'users#home', as: 'home'

  #route for sign up#
  get '/signup', to: "users#new", as: "new_user"

  # users
  post '/users', to: "users#create"

  #to do: change user_id as to 'user' or identify by action
  get '/users/:id', to: "users#show", as: "user_id"

  delete '/users/:id', to: "users#destroy"

  #sign in/sesssions#
  get '/signin', to: "sessions#new"

  #sessions
  post '/sessions', to: 'sessions#create'


  delete "/sessions", to: "sessions#destroy"


  ###route for user edit###
  get "/users/:id/edit", to: "users#edit"

  patch "/users/edit/:id", to: "users#update"


  #posts
  resources :posts, except: :destroy  # added to straighten out original, non-standard paths


  delete '/posts/:id', to: 'posts#destroy', as: 'delete_post'
  # get '/posts', to: 'posts#index', as: 'posts'
  # get '/posts/:id', to: 'posts#show', as: 'show_post'
  # get '/posts/:id/edit', to: 'posts#edit', as: 'edit_post'
  # patch '/posts/:id', to: 'posts#update'



  # ###update posts###
  # # post '/posts', to: 'posts#create'
  # # put '/posts/:id', to: 'posts#update'
  # # post '/posts/:id', to: 'posts#destroy'


#PERIODS

 #gets all periods
 get '/periods', to: 'periods#index', as: 'period_index'
 
#gets form to create new period
 get '/periods/new', to: 'periods#new', as: 'period_new'

 #posts new period to period index
 post '/periods', to: 'periods#create'
 
 #gets form to edit period
 get '/periods/:id/edit', to: 'periods#edit', as: 'period_edit'

 #gets individual period
 get '/periods/:id', to: 'periods#show'

 #updates individual period
 patch '/periods/:id', to: 'periods#update'
 
 #destryos individual period
 delete '/periods/:id', to: 'periods#destroy', as: 'period_delete'

end

