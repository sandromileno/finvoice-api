Rails.application.routes.draw do
  default_url_options host: 'localhost:3000'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'sign_in',
               sign_out: 'sign_out',
               registration: 'sign_up'
             },
             controllers: {
               sessions: 'auth/sessions',
               registrations: 'auth/registrations'
             }
  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[create show] do
        resources :invoices, only: %i[create show update] do
          resources :chargebacks, only: %i[create]
          resources :payments, only: %i[create]
        end
      end
      resources :invoices, only: %i[index] do
      end
    end
  end
end