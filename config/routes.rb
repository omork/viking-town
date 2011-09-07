VikingTown::Application.routes.draw do
  delete "fjord/abandon/:id",    :controller => :fjord,    :action => :abandon
  delete "village/abandon/:id",  :controller => :village,  :action => :abandon

  get    "fjord/list/:page",     :controller => :fjord,    :action => :list
  get    "fjord/list",           :controller => :fjord,    :action => :list
  get    "fjord/mine/:page",     :controller => :fjord,    :action => :mine
  get    "fjord/mine",           :controller => :fjord,    :action => :mine
  get    "fjord/show/:id",       :controller => :fjord,    :action => :show
  get    "home/index",           :controller => :home,     :action => :index
  get    "village/show/:id",     :controller => :village,  :action => :show

  post   "fjord/settle",         :controller => :fjord,    :action => :settle
  post   "fjord/update",         :controller => :fjord,    :action => :update
  post   "village/found",        :controller => :village,  :action => :found
  post   "village/update",       :controller => :village,  :action => :update
  post   "villager/allocate",    :controller => :villager, :action => :allocate
  post   "building/build/:id",   :controller => :building, :action => :build
  
  put    "building/assign/:id",  :controller => :building, :action => :assign
  
  devise_for :users
  root :to => "home#index"
end
