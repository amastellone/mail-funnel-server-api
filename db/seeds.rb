#Seeding

app = App.where(name: "bluehelmet-dev.myshopify.com").first_or_create!
# api_key: ENV['API_KEY'],
# api_secret: ENV['API_SECRET'],
# );

# Configs.create(name: "")

# Checkout
cart_create_hook = Hook.create(name: 'Cart / Create', identifier: 'cart_create');
cart_update_hook = Hook.create(name: 'Cart / Update', identifier: 'cart_update');

# Checkout
checkout_create_hook = Hook.create(name: 'Checkout / Create', identifier: 'checkout_create');
checkout_update_hook = Hook.create(name: 'Checkout / Update', identifier: 'checkout_update');

# Order
order_create_hook = Hook.create(name: 'Order / Create', identifier: 'order_create');
order_update_hook = Hook.create(name: 'Order / Update', identifier: 'order_update');



bundle config --delete bin    # Turn off Bundler's stub generator
rails app:update:bin          # Use the new Rails 5 executables
git add bin                   # Add bin/ to source control