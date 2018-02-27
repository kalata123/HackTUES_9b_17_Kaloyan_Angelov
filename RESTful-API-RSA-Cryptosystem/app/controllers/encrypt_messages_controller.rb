require "RSA"

class EncryptMessagesController < ApplicationController
	before_action :set_message, only: [:show]

	def create
		message = EncryptMessage.new({ :content => message_params[:message] })

		if message.content == nil
			render :html => "No message"
		else
			key = Key.find(params[:id])

			rsa = RSA.new(key.n, key.e, key.d)

			message.content = rsa.encrypt(message.content)

			respond_to do |format|
				if message.save
					format.json {
						render :json => {'id' => message.id}
					}
				end
			end
		end
	end

	def show
		message = EncryptMessage.find(params[:id])

		respond_to do |format|
			format.json {
				render :json => {'message' => message.content}
			}
		end
	end

private
	def set_message
		@message = EncryptMessage.find(params[:id])
	end

	def message_params
		params.permit(:message)
	end
end
