Rails.application.routes.draw do
  root to: "snacks#index"
  get ":key", to: "snacks#index"
end
