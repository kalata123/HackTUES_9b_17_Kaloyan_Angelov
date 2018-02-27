require 'spec_helper'

RSpec.describe DecryptMessagesController, type: :controller do
	let(:key) { FactoryGirl.create(:key) }

	describe "POST #create" do
		context "with valid attributes" do
			it "creates a new decrypted message" do
				expect {
					post :create, params: { id: key.id, message: FactoryGirl.build(:decrypt_message).content }, format: :json
				}.to change(DecryptMessage,:count).by(1)
			end

			it "renders a json object" do
				expected = { 
					:message => "Mene me nema v celata shema"
				}.to_json

				post :create, params: { id: key.id, message: FactoryGirl.build(:decrypt_message).content }, format: :json
				expect(response.body).to eq(expected)
			end
		end
		
		context "with invalid attributes" do
			it "does not save the new decrypted message" do
				expect {
					post :create, params: { id: key.id }, format: :json
				}.not_to change(DecryptMessage,:count)
			end

			it "renders a string object" do
				expected = "No message"
				post :create, params: { id: key.id }, format: :json
				expect(response.body).to eq(expected)
			end
		end
	end
end
