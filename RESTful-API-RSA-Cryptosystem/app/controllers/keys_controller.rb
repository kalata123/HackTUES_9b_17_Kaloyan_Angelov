require "RSA"

class KeysController < ApplicationController
	before_action :set_key, only: [:show]

	def create
		key = Key.new(key_params)

		if(!params.has_key?(:n) || !params.has_key?(:e) || !params.has_key?(:d))
			keyParams = RSA.new(0, 0, 0).new_key

			key.n = keyParams[0]
			key.e = keyParams[1]
			key.d = keyParams[2]
 		end

		respond_to do |format|
			if key.save
				format.json {
					render :json => {'id' => key.id}
				}
			end
		end
	end

	def show
		key = Key.find(params[:id])

		respond_to do |format|
			format.json {
				render :json => {'n' => key.n, 'e' => key.e, 'd' => key.d}
			}
		end
	end

private
	def set_key
		@key = Key.find(params[:id])
	end

	def key_params
		params.permit(:n, :e, :d)
	end
end
