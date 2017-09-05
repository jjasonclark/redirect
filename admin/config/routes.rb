Rails.application.routes.draw do
  resources :redirects do
    post :up, on: :member
    post :down, on: :member
  end

  root to: redirect('redirects')
end
