ActionController::Routing::Routes.draw do |map|

  map.resources :users, :only => :index
  map.resources :tweets
  
  map.user 'users/:screen_name', :controller => 'users', :action => 'show'
  
  map.root :controller => 'users', :action => 'index'
end
