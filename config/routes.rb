Rails.application.routes.draw do
  root to: "snacks#index"
  get ":key", to: "snacks#index", as: "snacks"
  post ":key", to: "snacks#update", as: "update_snacks"
end
