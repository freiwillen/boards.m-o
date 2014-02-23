Billboards::Application.routes.draw do
  
  root :to => "application#home"
  #root :to => "application#index"
  scope ':locale' do 
    root :to => "application#home"
    get 'contacts' => 'application#contacts'
    get 'team' => 'application#team'
    get 'clients' => 'application#clients'
    resource :user_session
    resources :users
    resources :imports do
      put :apply, :on => :member
    end
    resources :code_relations do
      post :import, :on => :collection
    end
    resources :offers do
      get :export, :on => :member
    end

    resources :reference_points do
      get :filter_options, :on => :member
    end

    resources :points do
      get :autocomplete, :on => :collection
      resources :boards
    end

    match 'boards/:code', :to => 'boards#by_code', :as => :board_by_code, :constraints => {:code => /.*/}
    match 'about', :to => 'application#stub', :as => :stub
    match 'logout', :to => 'user_sessions#destroy'
  end

end
