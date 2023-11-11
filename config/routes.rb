Rails.application.routes.draw do
  post "calculations/calculate", to: "calculations#calculate"
end
