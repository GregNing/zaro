# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  addr       :string
#  tel        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Address < ApplicationRecord
    belongs_to :user
    validates_presence_of :address,:tel,message: "必填!"
    def add_addressinfo!(user,addressInfo)
        self.tel = addressInfo.stTel
        self.addr = addressInfo.stAddr
        self.name = addressInfo.stName
        self.user = user
        self.save!
    end
end
