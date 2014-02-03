# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(:name => :admin)
Role.create(:name => :user)
User.create!(:email => 'white@sarov.info', :password => '12345678', :password_confirmation => '12345678', :username => "Admin")
User.find_by(email: "white@sarov.info").roles << Role.find_by_name(:admin)
for i in 1..100
  Post.create(user_id: 1, title: 'Firs post', approval: true,
            description: 'Lorem ipsum dolor sit amet, consectetur adipi',
            content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ipsum nisi, facilisis at odio non, tristique porttitor sapien. Vestibulum vitae ligula a lacus varius faucibus eget gravida ipsum. Proin nibh eros, viverra et lectus vel, ultricies varius lacus. Etiam orci nisl, pulvinar at ultricies eget, faucibus et nulla. Pellentesque lacus est, malesuada consequat hendrerit id, posuere eget felis. Phasellus ac elit eu magna hendrerit adipiscing. Nullam vitae diam sit amet nulla tincidunt condimentum. In in velit porta, molestie risus sit amet, blandit arcu. Sed blandit porttitor nibh, at laoreet nulla rhoncus tincidunt. In ac est eu elit volutpat interdum vitae sed nunc. Aenean sed sodales nulla. Aenean dui libero, volutpat in orci eget, condimentum varius magna.')
end
Category.create(title: "Policy")
Category.create(title: "Sport")
Category.create(title: "Culture")
Category.create(title: "Business")
Category.create(title: "Science")