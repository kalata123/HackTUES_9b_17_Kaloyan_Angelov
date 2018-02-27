# spec/factories/keys.rb

FactoryGirl.define do
	factory :key do
		n 893
		e 17
		d 341
	end

	factory :empty_key, parent: :key do
		n nil
		e nil
		d nil
	end
end
