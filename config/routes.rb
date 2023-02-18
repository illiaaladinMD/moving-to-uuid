Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "data#index"
  post 'generate_test_data', to: 'data#generate'
end
