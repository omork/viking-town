VikingTown::Application.routes.draw do
  resources :sacrifices, except: [:destroy, :delete, :edit, :update]

  delete "fjord/abandon/:id",    :controller => :fjord,      :action => :abandon
  delete "village/abandon/:id",  :controller => :village,    :action => :abandon
  delete "fleets/remove/:id",    :controller => :fleets,     :action => :remove
  delete "fleets/:id",           :controller => :fleets,     :action => :disband

  get    "fleets",               :controller => :fleets,     :action => :list
  get    "fleets/show/:id",      :controller => :fleets,     :action => :show,     as: :fleet
  get    "fjord/list/:page",     :controller => :fjord,      :action => :list
  get    "fjord/list",           :controller => :fjord,      :action => :list
  get    "fjord/mine/:page",     :controller => :fjord,      :action => :mine
  get    "fjord/mine",           :controller => :fjord,      :action => :mine
  get    "fjord/show/:id",       :controller => :fjord,      :action => :show
  get    "home/index",           :controller => :home,       :action => :index
  get    "village/show/:id",     :controller => :village,    :action => :show
  get    "sacrifices/show/:id",  :controller => :sacrifices, :action => :show

  post   "fleets/assemble",      :controller => :fleets,     :action => :assemble, as: :new_fleet
  post   "fjord/settle",         :controller => :fjord,      :action => :settle
  post   "fjord/update",         :controller => :fjord,      :action => :update
  post   "village/found",        :controller => :village,    :action => :found
  post   "village/update",       :controller => :village,    :action => :update
  post   "villager/allocate",    :controller => :villager,   :action => :allocate
  post   "building/build/:id",   :controller => :building,   :action => :build
  
  put    "building/assign/:id",  :controller => :building,   :action => :assign
  put    "fleets/add",           :controller => :fleets,     :action => :add

  devise_for :users
  root :to => "home#index", :controller => :home, :action => :index
end
