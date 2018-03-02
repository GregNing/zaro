# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  total            :integer          default(0)
#  user_id          :integer
#  billing_name     :string
#  billing_address  :string
#  shipping_name    :string
#  shipping_address :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  token            :string
#

class Order < ApplicationRecord
  before_create :generate_token
  belongs_to :user
  validates :billing_name, presence: {message: "請填寫購買人姓名!"}
  validates :billing_address, presence: {message: "請填寫購買人地址!"}
  validates :shipping_name, presence: {message: "請填寫收件人姓名!"}
  validates :shipping_address, presence: {message: "請填寫收件人地址!"}
  has_many :product_lists
  def generate_token
    self.token = SecureRandom.uuid
  end
  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end  
  def pay!
    self.update_columns(is_paid: true )
  end
end
