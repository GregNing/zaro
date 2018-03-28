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
#  category_id :integer
#  s           :integer          default(0)
#  m           :integer          default(0)
#  l           :integer          default(0)
#

class Product < ApplicationRecord
    validates :name,presence: {message: "請填寫商品名稱"}  
    validates :description,presence: {message: "請填寫商品內容"}
    validates :price,numericality: {greater_than: 0 ,message: "請輸入數字，價格不得為0！"}    
    validates :image,presence: {message: "請上傳商品圖片!"}
    validates :category_id,presence: {message: "請選擇商品類型!"}
    validates :s, numericality: { message: "請輸入數字!"  }
    validates :m, numericality: { message: "請輸入數字!"  }
    validates :l, numericality: { message: "請輸入數字!"  }
    #掛上 掛載carrwave
    mount_uploader :image, ImageUploader
    belongs_to :user   
    belongs_to :category
    has_many :cart_items, dependent: :destroy
    #允許直接透過Product 塞資料
    # accepts_nested_attributes_for :sizes
    #型號 model
    # has_many :sizes
    #排序所使用
    acts_as_list
    scope :order_position, ->{ order("position ASC") }
    
end
