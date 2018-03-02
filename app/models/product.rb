class Product < ApplicationRecord
    validates :name,presence: {message: "請填寫商品名稱"}  
    validates :description,presence: {message: "請填寫商品內容"}
    validates :price,numericality: {greater_than: 0 ,message: "請輸入數字，價格不得為0！"}
    validates :quantity,numericality: {message: "請輸入數字！"}
    mount_uploader :image, ImageUploader
    belongs_to :user
    belongs_to :cart
end
