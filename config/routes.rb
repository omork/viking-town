VikingTown::Application.routes.draw do
  delete "building/destroy/:id", :controller => :building, :action => :destroy
  delete "fjord/abandon/:id",    :controller => :fjord,    :action => :abandon
  delete "ship/scuttle/:id",     :controller => :ship,     :action => :scuttle
  delete "village/abandon/:id",  :controller => :village,  :action => :abandon

  get    "building/show/:id",    :controller => :building, :action => :show
  get    "fjord/list/:page",     :controller => :fjord,    :action => :list
  get    "fjord/list",           :controller => :fjord,    :action => :list
  get    "fjord/mine/:page",     :controller => :fjord,    :action => :mine
  get    "fjord/mine",           :controller => :fjord,    :action => :mine
  get    "fjord/show/:id",       :controller => :fjord,    :action => :show
  get    "home/index",           :controller => :home,     :action => :index
  get    "nation/list/:page",    :controller => :nation,   :action => :list
  get    "nation/show/:id",      :controller => :nation,   :action => :show
  get    "ship/show/:id",        :controller => :ship,     :action => :show
  get    "viking/show/:id",      :controller => :viking,   :action => :show
  get    "village/show/:id",     :controller => :village,  :action => :show
  get    "villager/show/:id",    :controller => :villager, :action => :show

  post   "building/build",       :controller => :building, :action => :build
  post   "building/update",      :controller => :building, :action => :update
  post   "fjord/settle",         :controller => :fjord,    :action => :settle
  post   "fjord/update",         :controller => :fjord,    :action => :update
  post   "nation/align",         :controller => :nation,   :action => :nation
  post   "ship/build",           :controller => :ship,     :action => :build
  post   "ship/update",          :controller => :ship,     :action => :update
  post   "viking/allocate",      :controller => :viking,   :action => :allocate
  post   "viking/update",        :controller => :viking,   :action => :update
  post   "village/found",        :controller => :village,  :action => :found
  post   "village/update",       :controller => :village,  :action => :update
  post   "villager/allocate",    :controller => :villager, :action => :allocate
  post   "villager/update",      :controller => :villager, :action => :update
  
  devise_for :users
  root :to => "home#index"
end
