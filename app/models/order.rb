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
#  is_paid          :boolean          default(FALSE)
#  payment_method   :string
#  aasm_state       :string           default("order_placed")
#

class Order < ApplicationRecord
  before_create :generate_token
  belongs_to :user
  validates :billing_name, presence: {message: "請填寫購買人姓名!"}
  validates :billing_address, presence: {message: "請填寫購買人地址!"}
  validates :shipping_name, presence: {message: "請填寫收件人姓名!"}
  validates :shipping_address, presence: {message: "請填寫收件人地址!"}
  has_many :product_lists
  #隨機取得一組亂碼要給訂單編號使用 SecureRandom可以產生亂碼
  def generate_token
    self.token = SecureRandom.uuid
  end
  #付款方式 使用維信 或是 支付寶付款
  def set_payment_with!(method)
    self.update_attributes(payment_method: method.to_s )
  end
  #已付過款
  def pay!
    self.update_attributes(is_paid: true )
  end
  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned
    #after_commit 已付過款
    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

end
