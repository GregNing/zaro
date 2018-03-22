# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Category < ApplicationRecord
    has_many :products
    belongs_to :user
    validates :name,presence: {message: "請輸入種類名稱!"}
end
