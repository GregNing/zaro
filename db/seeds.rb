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