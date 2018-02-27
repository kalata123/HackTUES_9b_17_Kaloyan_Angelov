require "RSA"

class DecryptMessagesController < ApplicationController
	def create
		message = DecryptMessage.new({ :content => message_params[:message] })

		if message.content == nil
			render :html => "No message"
		else
			key = Key.find(params[:id])

			rsa = RSA.new(key.n, key.e, key.d)

			message.content = rsa.decrypt(message.content)

			respond_to do |format|
				if message.save
					format.json {
						render :json => {'message' => message.content}
					}
				end
			end
		end
	end

private
	def message_params
		params.permit(:message)
	end
end
