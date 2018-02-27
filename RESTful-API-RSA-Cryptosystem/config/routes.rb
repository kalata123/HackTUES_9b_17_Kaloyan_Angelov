Rails.application.routes.draw do
	post "/rsas" => "keys#create"

	get "/rsas/:id" => "keys#show"

	post "/rsas/:id/encrypt_messages/" => "encrypt_messages#create"

	get "/rsas/:id/encrypt_messages/:id" => "encrypt_messages#show"

	post "/rsas/:id/decrypt_messages/" => "decrypt_messages#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
