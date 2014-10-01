Rails.application.routes.draw do
  resources :summaries, only: [:new, :create]
  resources :votes, only: [:create]

  resources :publications, only: [:create, :update] do
    collection do
      post 'get_pubs', as: :get_pubs
      get 'summary_vote', as: :summary_vote
    end
  end

  get 'viz/index'
  root 'viz#index'
end