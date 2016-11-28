#Seeding

app = App.where(name: "bluehelmet-dev").first_or_create!
# job1 = Job.where()

# api_key: ENV['API_KEY'],
# api_secret: ENV['API_SECRET'],
# );

# Configs.create(name: "")

# Checkout
cart_create_hook = Hook.create(name: 'Cart / Create', identifier: 'cart_create');
cart_update_hook = Hook.create(name: 'Cart / Update', identifier: 'cart_update');
cart_abandon_hook = Hook.create(name: 'Cart / Abandon', identifier: 'cart_abandon');

# Checkout
checkout_create_hook = Hook.create(name: 'Checkout / Create', identifier: 'checkout_create');
checkout_update_hook = Hook.create(name: 'Checkout / Update', identifier: 'checkout_update');

# Order
order_create_hook = Hook.create(name: 'Order / Create', identifier: 'order_create');
order_update_hook = Hook.create(name: 'Order / Update', identifier: 'order_update');