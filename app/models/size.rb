# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  product_id :integer
#  s          :integer          default(0)
#  m          :integer          default(0)
#  l          :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Size < ApplicationRecord
    belongs_to :product
    validates :s, numericality: { message: "請輸入數字!"  }
    validates :m, numericality: { message: "請輸入數字!"  }
    validates :l, numericality: { message: "請輸入數字!"  }
end
