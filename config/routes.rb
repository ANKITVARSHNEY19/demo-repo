Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'login', to: 'users#login'

  post 'register', to: 'users#register'

  get 'questions_list', to: 'users#questions_list'

  post 'answer_list', to: 'users#answer_list'


  get '*other', to: 'static#index'
end
