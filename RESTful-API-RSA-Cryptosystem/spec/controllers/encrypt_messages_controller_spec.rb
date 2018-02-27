require 'spec_helper'

RSpec.describe EncryptMessagesController, type: :controller do
	describe "GET #show" do
		let(:encrypt_message) { FactoryGirl.create(:encrypt_message) }

		it "assigns the requested message to encrypt_message" do
			get :show, params: { id: encrypt_message.id }, format: :json
			expect(assigns(:message)).to eq(encrypt_message)
		end

		it "renders a json object" do
			expected = { 
				:message => "Mene me nema v celata shema"
			}.to_json

			get :show, params: { id: encrypt_message.id }, format: :json
			expect(response.body).to eq(expected)
		end
	end

	describe "POST #create" do
		let(:key) { FactoryGirl.create(:key) }

		context "with valid attributes" do
			it "creates a new encrypted message" do
				expect {
					post :create, params: { id: key.id, message: FactoryGirl.build(:encrypt_message).content }, format: :json
				}.to change(EncryptMessage,:count).by(1)
			end

			it "renders a json object" do
				encrypt_message = FactoryGirl.create(:encrypt_message)

				expected = { 
					:id => encrypt_message.id + 1
				}.to_json

				post :create, params: { id: key.id, message: encrypt_message.content }, format: :json
				expect(response.body).to eq(expected)
			end
		end
		
		context "with invalid attributes" do
			it "does not save the new encrypted message" do
				expect {
					post :create, params: { id: key.id }, format: :json
				}.not_to change(EncryptMessage,:count)
			end
		  
			it "renders a string object" do
				expected = "No message"
				post :create, params: { id: key.id }, format: :json
				expect(response.body).to eq(expected)
			end
		end
	end
end
