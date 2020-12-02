Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root
  scope "/:locale" do
    get '/', to: 'gems#index'
    resources :gems 
    resources :fpy, only:[:create,:index ] 
    resources :indicators, only:[:create,:index ] 
    resources :ascendentes, only:[:create,:index ] 
  end

end
