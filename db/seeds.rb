Role.create(:name => :admin)
Role.create(:name => :user)
User.create!(:email => 'white@sarov.info', :password => '12345678', :password_confirmation => '12345678', :username => "Admin")
User.find_by(email: "white@sarov.info").roles << Role.find_by_name(:admin)
for i in 1..100
  Post.create(user_id: 1, title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', approval: true,
            description: 'Nam sodales dolor eu elementum pellentesque. Donec accumsan, nisi ut convallis tincidunt, lacus enim fringilla nisl, eget suscipit lorem massa eu tortor.',
            content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ipsum nisi, facilisis at odio non, tristique porttitor sapien. Vestibulum vitae ligula a lacus varius faucibus eget gravida ipsum. Proin nibh eros, viverra et lectus vel, ultricies varius lacus. Etiam orci nisl, pulvinar at ultricies eget, faucibus et nulla. Pellentesque lacus est, malesuada consequat hendrerit id, posuere eget felis. Phasellus ac elit eu magna hendrerit adipiscing. Nullam vitae diam sit amet nulla tincidunt condimentum. In in velit porta, molestie risus sit amet, blandit arcu. Sed blandit porttitor nibh, at laoreet nulla rhoncus tincidunt. In ac est eu elit volutpat interdum vitae sed nunc. Aenean sed sodales nulla. Aenean dui libero, volutpat in orci eget, condimentum varius magna.')
end
Category.create(title: "policy")
Category.create(title: "sport")
Category.create(title: "culture")
Category.create(title: "business")
Category.create(title: "science")