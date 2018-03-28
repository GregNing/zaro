# == Schema Information
#
# Table name: order_details
#
#  id                  :integer          not null, primary key
#  order_id            :integer
#  product_name        :string
#  product_description :string
#  image               :string
#  product_price       :integer
#  quantity            :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class OrderDetail < ApplicationRecord
    belongs_to :order
    validates_presence_of :product_name, :product_price,:quantity,:product_description,:image, message: "必填!"
    mount_uploader :image, ImageUploader
end
