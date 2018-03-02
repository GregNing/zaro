# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price       :integer
#  quantity    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  image       :string
#  position    :integer
#

class Product < ApplicationRecord
    validates :name,presence: {message: "請填寫商品名稱"}  
    validates :description,presence: {message: "請填寫商品內容"}
    validates :price,numericality: {greater_than: 0 ,message: "請輸入數字，價格不得為0！"}
    validates :quantity,numericality: {message: "請輸入數字！"}
    mount_uploader :image, ImageUploader
    belongs_to :user   
    has_many :cart_items, dependent: :destroy
    acts_as_list
    scope :order_position, ->{ order("position ASC") }
    
end
