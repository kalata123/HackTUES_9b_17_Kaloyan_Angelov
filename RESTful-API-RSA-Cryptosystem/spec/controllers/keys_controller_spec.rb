require 'spec_helper'

RSpec.describe KeysController, type: :controller do
	describe "GET #show" do
		let(:rsa_key) { FactoryGirl.create(:key) }

		it "assigns the requested key to rsa_key" do
			get :show, params: { id: rsa_key.id }, format: :json
			expect(assigns(:key)).to eq(rsa_key)
		end
		
		it "renders a json object" do
			expected = { 
				:n => 893,
				:e => 17,
				:d => 341
			}.to_json

			get :show, params: { id: rsa_key.id }, format: :json
			expect(response.body).to eq(expected)
		end
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "creates a new key" do
				expect {
					post :create, params: { key: FactoryGirl.attributes_for(:key) }, format: :json
				}.to change(Key,:count).by(1)
			end

			it "renders a json object" do
				key = FactoryGirl.create(:key)

				expected = { 
					:id => key.id.to_i + 1
				}.to_json

				post :create, params: { key: FactoryGirl.attributes_for(:key) }, format: :json
				expect(response.body).to eq(expected)
			end
		end
		
		context "with empty attributes" do
			it "creates a new key" do
				expect{
					post :create, params: { key: FactoryGirl.attributes_for(:empty_key) }, format: :json
				}.to change(Key,:count).by(1)
			end

			it "renders a json object" do
				key = FactoryGirl.create(:empty_key)

				expected = { 
					:id => key.id.to_i + 1
				}.to_json

				post :create, params: { key: FactoryGirl.attributes_for(:empty_key) }, format: :json
				expect(response.body).to eq(expected)
			end
		end 
	end
end
