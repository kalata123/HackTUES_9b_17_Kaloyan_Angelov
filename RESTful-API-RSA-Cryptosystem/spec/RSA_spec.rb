#BDD for RSA model

require "RSA"

RSpec.describe RSA do
	describe "n, e and d" do
		let(:rsa) { RSA.new(9, 6, 3) }

		context "n" do
			it "returns 9" do
				expect(rsa.n).to eql(9)
			end
		end

		context "e" do
			it "returns 6" do
				expect(rsa.e).to eql(6)
			end
		end

		context "d" do
			it "returns 3" do
				expect(rsa.d).to eql(3)
			end
		end
	end

	describe "encrypts" do
		let(:rsa) { RSA.new(893, 17, 341) }

		context "messages containing only alpha characters" do
			it "encrypts 'TUES'" do
				expect(rsa.encrypt("TUES")).to eql("MTAxMQ==\n@MDExMQ==\n@|MTAxMA==\n@MTExMQ==\n@MDE=\n|MTExMQ==\n@MDAwMQ==\n@MQ==\n|MTAwMQ==\n@MDEwMA==\n@MA==\n")
			end
		end

		context "messages containing only numeric characters" do
			it "encrypts '92341245'" do
				expect(rsa.encrypt("92341245")).to eql("MTExMA==\n@MTEwMQ==\n@MQ==\n|MTAxMA==\n@MDEwMQ==\n@MQ==\n|MTExMQ==\n@MTAwMA==\n@MQ==\n|MTEwMA==\n@MTExMQ==\n@MA==\n|MTAxMA==\n@MDEx\n|MTAxMA==\n@MDEwMQ==\n@MQ==\n|MTEwMA==\n@MTExMQ==\n@MA==\n|MTAxMA==\n@MDExMA==\n@")
			end
		end

		context "messages containing only non-alphanumeric characters" do
			it "encrypts '#$@!*&'" do
				expect(rsa.encrypt("#$@!*&")).to eql("MTEwMA==\n@MDEwMQ==\n@MQ==\n|MTEwMA==\n@MDAwMA==\n@MQ==\n|MTAwMA==\n@MDAwMA==\n@MDE=\n")
			end
		end

		context "messages containing only space characters" do
			it "encrypts '      '" do
				expect(rsa.encrypt("      ")).to eql("MTAwMA==\n@MDEwMQ==\n@MTE=\n|MTAwMA==\n@MDEwMQ==\n@MTE=\n|MTAwMA==\n@MDEwMQ==\n@MTE=\n|MTAwMA==\n@MDEwMQ==\n@MTE=\n|MTAwMA==\n@MDEwMQ==\n@MTE=\n|MTAwMA==\n@MDEwMQ==\n@MTE=\n")
			end
		end

		context "empty message" do
			it "encrypts ''" do
				expect(rsa.encrypt("")).to eql("")
			end
		end
	end

	describe "encrypts and decrypts" do
		let(:rsa) { RSA.new(*RSA.new(0, 0, 0).new_key) }

		context "long messages" do
			it "encrypts and decrypts 'I wonder if I've been changed in the night. Let me think. Was I the same when I got up this morning? I almost think I can remember feeling a little different. But if I'm not the same, the next question is 'Who in the world am I?' Ah, that's the great puzzle!'" do
				long_message = "I wonder if I've been changed in the night. Let me think. Was I the same when I got up this morning? I almost think I can remember feeling a little different. But if I'm not the same, the next question is 'Who in the world am I?' Ah, that's the great puzzle!"

				expect(rsa.decrypt(rsa.encrypt(long_message))).to eql(long_message)
			end
		end

		context "messages containing only numeric characters" do
			it "encrypts and decrypts '0884410530'" do
				expect(rsa.decrypt(rsa.encrypt("0884410530"))).to eql("0884410530")
			end
		end

		context "messages containing only non-alphanumeric characters" do
			it "encrypts and decrypts '~!@#$%^&*()_+'" do
				expect(rsa.decrypt(rsa.encrypt("~!@#$%^&*()_+"))).to eql("~!@#$%^&*()_+")
			end
		end

		context "messages containing only alphanumeric and space characters" do
			it "encrypts and decrypts '7h3 qu1ck br0wn f0x'" do
				expect(rsa.decrypt(rsa.encrypt("7h3 qu1ck br0wn f0x"))).to eql("7h3 qu1ck br0wn f0x")
			end
		end

		context "messages containing only space characters" do
			it "encrypts and decrypts '      '" do
				expect(rsa.decrypt(rsa.encrypt("      "))).to eql("      ")
			end
		end

		context "empty message" do
			it "encrypts and decrypts ''" do
				expect(rsa.decrypt(rsa.encrypt(""))).to eql("")
			end
		end
	end
end
