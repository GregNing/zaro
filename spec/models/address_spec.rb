require 'rails_helper'

RSpec.describe Address, type: :model do
   describe ".Address" do
        context "insert into address" do
            #use let to new order
            #取得使用者
            let(:user) { User.first }
            #新增訂單
            let(:address) { Address.new }
            it "Start Insert to address" do
            address.address = "測試!"
            address.tel = "(02)2222-2222"
            
            address.add_addressinfo!(user)
            expect(address).to be_valid            
            end
        end
    end
end
