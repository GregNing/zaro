# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if  User.find_by(email: "123456@gom.com").nil?    
    u = User.new
    u.email = "123456@gom.com"
    u.nickname = 'greg'
    u.password = "123456"
    u.password_confirmation = "123456"
    u.is_admin = true
    u.save
    puts "123456@gom.com已經建立完畢"
else
    puts "123456@gom.com已經存在"
end
#下面這段是跑測試 資料所使用的
#excute seed.rb to test db 
#rake db:seed RAILS_ENV=test
if Rails.env == "test"
    
    #建立種類
    if Category.find_by(name: "洋裝").nil?
        category = Category.new
        category.name = "洋裝"
        category.user_id = 1
        category.save!
        puts "建立商品種類完成"
    else
        puts "商品種類已經存在"
    end    
    #建立產品
    if Product.find_by(name: "美妙人生舒適彈力後印字棉質上衣").nil?        
    product = Product.new
    product.name = "美妙人生舒適彈力後印字棉質上衣"
    product.description = "美妙人生舒適彈力後印字棉質上衣"
    product.price = 399
    product.user_id = 1
    product.image = "1-bs__1_.webp"
    product.category_id = 1
    product.s = 2
    product.m = 2
    product.l = 2
    product.save!
        puts "建立 美妙人生舒適彈力後印字棉質上衣 完成"
    else
        puts "產品 美妙人生舒適彈力後印字棉質上衣 已經存在"
    end
    #建立 購物車
    if Cart.find_by(id: 1).nil?
        cart = Cart.new
        cart.user_id  = 1
        cart.save!
        puts "建立 購物車 id = 1 完成"
    else
        puts "產品 購物車 id = 1 已經存在"        
    end
    #建立 購物車 商品
    if CartItem.where(id: [1]).blank?        
        cartitem1 = CartItem.new(cart_id: 1,product_id: 1,quantity: "{:m=>4, :s=>3}")        
        cartitem1.save!
        puts "建立 購物車 product_id = 1 商品完成"
    else
        puts "購物車 商品 product_id = 1 已經完成"
    end
end