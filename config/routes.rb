Proteus::Engine.routes.draw do
  root to: "welcome#show"

  resources :whitelabeled_domains do
    resources :properties
  end
end
